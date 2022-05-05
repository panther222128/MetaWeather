//
//  WeatherUseCase.swift
//  MetaWeather
//
//  Created by Jun Ho JANG on 2022/04/29.
//

import Foundation

protocol MetaWeatherUseCase {
    func fetchSearchResults(searchKeyword: String, completion: @escaping (Result<[LocationSearchResult], DataTransferServiceError>) -> Void)
    func fetchLocationWeather(locationParameter: Int, completion: @escaping (Result<LocationWeathers, DataTransferServiceError>) -> Void)
}

final class DefaultMetaWeatherUseCase: MetaWeatherUseCase {
    
    private let apiEndpoint: APIEndpoint
    private let dataTransferService: DataTransferService

    init() {
        self.apiEndpoint = DefaultAPIEndpoint()
        self.dataTransferService = DefaultDataTransferService()
    }
    
    func fetchSearchResults(searchKeyword: String, completion: @escaping (Result<[LocationSearchResult], DataTransferServiceError>) -> Void) {
        let endpoint = apiEndpoint.getSearchEndpoint(with: searchKeyword)
        self.dataTransferService.request(with: endpoint, dataType: [LocationSearchResultResponseDTO].self) { result in
            switch result {
            case .success(let data):
                let transformedToDomain = data.map( { $0.convertToDomain() } )
                completion(.success(transformedToDomain))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchLocationWeather(locationParameter: Int, completion: @escaping (Result<LocationWeathers, DataTransferServiceError>) -> Void) {
        let endpoint = apiEndpoint.getLocationEndpoint(with: locationParameter)
        self.dataTransferService.request(with: endpoint, dataType: LocationWeatherResponseDTOs.self) { result in
            switch result {
            case .success(let data):
                let transformedToDomain = data.convertToDomain()
                completion(.success(transformedToDomain))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
