//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import Foundation

enum WeatherAPI {
    case currentWeather
    case cityCurrentWeather(id: Int)
    case forecase5(city: String)
    case icon(id: String)
    
    var endpoint: URL {
        
        switch self {
        case .currentWeather:
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.654165&lon=127.049696" + "&appid=\(APIKey.openWeatherAPIKey)")!
        case .cityCurrentWeather(let id):
            return URL(string: " https://api.openweathermap.org/data/2.5/weather?id=\(id)" + "&appid=\(APIKey.openWeatherAPIKey)")!
        case .forecase5(let city):
            return URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)" + "&appid=\(APIKey.openWeatherAPIKey)" + "&lang=kr")!
        case .icon(let id):
            return URL(string: "https://openweathermap.org/img/wn/\(id)@2x.png")!
        }
    }
    
    
    
}
