//
//  Weather.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import Foundation

struct WeatherResult: Decodable {
    let weather: [Weather]
    let main: Temperature
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let snow: Snow?
    let id: Int
    let name: String
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temperature: Decodable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
    
    var currentTemp: Double {
        return temp - 273.15
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct Clouds: Decodable {
    let all: Int
}

struct Rain: Decodable {
    let volumePer1h: Double?
    let volumePer3h: Double?
}

struct Snow: Decodable {
    let volumePer1h: Double?
    let volumePer3h: Double?
}
