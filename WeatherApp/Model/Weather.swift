//
//  Weather.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import Foundation

struct WeatherForecast: Decodable {
    let list: [Weather]
    let city: City
}

struct Weather: Decodable {
    let weather: [WeatherStatus]
    let main: Temperature
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let snow: Snow?
    let id: Int?
    let name: String?
    let dt_txt: String?
}

struct WeatherStatus: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temperature: Decodable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
    
    var celsiusTemperature: Double {
        let result = String(format: "%.1f", temp - 273.15 )
        return Double(result)!
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

struct City: Decodable {
    let name: String
}
