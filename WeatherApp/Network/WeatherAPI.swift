//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import Foundation

enum WeatherAPI {
    case currentWeather
    case cityWeatherforecast5(id: Int)
    case forecast5(city: String)
    case icon(id: String)
    
    var endpoint: URL {
        
        switch self {
        case .currentWeather:
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.654165&lon=127.049696" + "&appid=\(APIKey.openWeatherAPIKey)")!
        case .cityWeatherforecast5(let id):
            return URL(string: "https://api.openweathermap.org/data/2.5/forecast?id=\(id)" + "&appid=\(APIKey.openWeatherAPIKey)" + "&lang=kr")!
        case .forecast5(let city):
            return URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)" + "&appid=\(APIKey.openWeatherAPIKey)" + "&lang=kr")!
        case .icon(let id):
            return URL(string: "https://openweathermap.org/img/wn/\(id)@2x.png")!
        }
    }
    
}
