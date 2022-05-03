//
//  LocationSearchResult.swift
//  MetaWeather
//
//  Created by Jun Ho JANG on 2022/04/28.
//

import Foundation

struct LocationSearchResults {
    
    let locationSearchResults: [LocationSearchResult]
    
}

struct LocationSearchResult {
    
    let title: String
    let locationType: String
    let woeid: Int
    let lattLong: String
    
}
