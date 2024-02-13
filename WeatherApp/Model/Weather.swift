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
    let dt_txt: String
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
    let temp_min: Double
    let temp_max: Double
    
    var roundedTemp: String {
        let celsius = temp - 273.15
        let result = round(celsius)
        return String(format: "%.0f", result) + "°"
    }
    
    var celsiusTemperature: String {
        let result = String(format: "%.1f", temp - 273.15 ) + "°"
        return result
    }
    
    var minTemp: String {
        let result = "최저 " + String(format: "%.1f", temp_min - 273.15 ) + "°"
        return result
    }
    
    var maxTemp: String {
        let result = "최고 " + String(format: "%.1f", temp_max - 273.15 ) + "°"
        return result
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

struct DailyWeather {
    var day: String
    var icon: String
    var temp_min: Double
    var temp_max: Double
    
    var minTemp: String {
        let result = "최저 " + String(format: "%.1f", temp_min - 273.15 ) + "°"
        return result
    }
    
    var maxTemp: String {
        let result = "최고 " + String(format: "%.1f", temp_max - 273.15 ) + "°"
        return result
    }
}
