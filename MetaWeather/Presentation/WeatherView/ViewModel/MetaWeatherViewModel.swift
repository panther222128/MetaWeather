//
//  WeatherViewModel.swift
//  MetaWeather
//
//  Created by Jun Ho JANG on 2022/04/29.
//

import Foundation

protocol MetaWeatherViewModel {
    var searchResultsStorage: Observable<[LocationSearchResult]> { get set }
    var locationWeathersStorage: Observable<[LocationWeathers]> { get set }
    var isError: Observable<Bool> { get set }
    var error: Observable<Error?> { get set }
    
    func fetchSearchResult(searchKeyword: String, completion: @escaping (Result<[LocationSearchResult], Error>) -> Void)
    func removeAllData()
}

final class DefaultMetaWeatherViewModel: MetaWeatherViewModel {
    
    private let metaWeatherUseCase: MetaWeatherUseCase
    var searchResultsStorage: Observable<[LocationSearchResult]>
    var locationWeathersStorage: Observable<[LocationWeathers]>
    var isError: Observable<Bool>
    var error: Observable<Error?>
    private var woeids: [Int]

    init() {
        self.metaWeatherUseCase = DefaultMetaWeatherUseCase()
        self.searchResultsStorage = Observable([])
        self.locationWeathersStorage = Observable([])
        self.isError = Observable(false)
        self.error = Observable(nil)
        self.woeids = []
    }
    
    func fetchSearchResult(searchKeyword: String, completion: @escaping (Result<[LocationSearchResult], Error>) -> Void) {
        self.metaWeatherUseCase.fetchSearchResults(searchKeyword: searchKeyword, completion: { result in
            switch result {
            case .success(let data):
                let observable = Observable(data)
                self.searchResultsStorage = observable
                self.woeids = data.map( { $0.woeid } )
                self.fetchConsolidatedWeathers { result in
                    switch result {
                    case .success(_):
                        self.isError.value = false
                        self.error.value = nil
                        completion(.success(observable.value))
                    case .failure(let error):
                        self.isError.value = true
                        self.error.value = error
                        completion(.failure(error))
                    }
                }
                self.isError.value = false
                self.error.value = nil
                completion(.success(data))
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
                completion(.failure(error))
            }
        })
    }
    
    private func fetchConsolidatedWeather(locationParameter: Int, completion: @escaping (Result<LocationWeathers, Error>) -> Void) {
        self.metaWeatherUseCase.fetchConsolidatedWeather(locationParameter: locationParameter) { result in
            switch result {
            case .success(let data):
                self.isError.value = false
                self.error.value = nil
                completion(.success(data))
            case .failure(let error):
                self.isError.value = true
                self.error.value = error
                completion(.failure(error))
            }
        }
    }

    private func fetchConsolidatedWeathers(completion: @escaping (Result<LocationWeathers, Error>) -> Void) {
        for i in self.woeids {
            self.fetchConsolidatedWeather(locationParameter: i) { result in
                switch result {
                case .success(let data):
                    let observableValue = Observable(data).value
                    self.locationWeathersStorage.value.append(observableValue)
                    self.isError.value = false
                    self.error.value = nil
                    completion(.success(data))
                case .failure(let error):
                    self.isError.value = true
                    self.error.value = error
                    completion(.failure(error))
                }
            }
        }
    }
    
    func removeAllData() {
        self.searchResultsStorage = Observable([])
        self.locationWeathersStorage = Observable([])
        self.woeids.removeAll()
    }
    
}
