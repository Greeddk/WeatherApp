//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import Foundation

enum WeatherAPI {
    case currentWeather
    case cityWeather
    case forecase5
    case icon
    
    var endpoint: URL {
        
        switch self {
        case .currentWeather:
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.654165&lon=127.049696" + "&appid=\(APIKey.openWeatherAPIKey)")!
        case .cityWeather:
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.654165&lon=127.049696" + "&appid=\(APIKey.openWeatherAPIKey)")!
        case .forecase5:
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.654165&lon=127.049696" + "&appid=\(APIKey.openWeatherAPIKey)")!
        case .icon:
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.654165&lon=127.049696" + "&appid=\(APIKey.openWeatherAPIKey)")!
        }
    }
    
    
    
}
