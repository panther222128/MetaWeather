//
//  APIEndpoint.swift
//  MetaWeather
//
//  Created by Jun Ho JANG on 2022/04/29.
//

import Foundation

enum Scheme: String {
    case https = "https"
}

enum Host: String {
    case base = "www.metaweather.com"
}

enum Path: String {
    case basePath = ""
    case locationPath = "/api/location/"
    case searchPath = "/api/location/search/"
}

protocol APIEndpoint {
    func getSearchEndpoint(with parameter: String) -> Endpoint
    func getLocationEndpoint(with locationParameter: Int) -> Endpoint
}

struct DefaultAPIEndpoint: APIEndpoint {
    
    func getSearchEndpoint(with searchKeyword: String) -> Endpoint {
        let queryParameter = ["query":"\(searchKeyword)"]
        return Endpoint(scheme: Scheme.https.rawValue, host: Host.base.rawValue, basePath: Path.basePath.rawValue, path: Path.searchPath.rawValue, parameter: nil, queryParameters: queryParameter, method: .get)
    }
    
    func getLocationEndpoint(with parameter: Int) -> Endpoint {
        return Endpoint(scheme: Scheme.https.rawValue, host: Host.base.rawValue, basePath: Path.basePath.rawValue, path: Path.locationPath.rawValue, parameter: parameter, queryParameters: nil, method: .get)
    }
    
}
