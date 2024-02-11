//
//  CityInfo.swift
//  WeatherApp
//
//  Created by Greed on 2/11/24.
//

import Foundation

struct CityInfo: Hashable, Decodable {
    let id: Int
    let name: String
    let country: String
    let coord: Coordinate
    let state: String?
}

struct Coordinate: Hashable, Decodable {
    let lon: Double
    let lat: Double
}


