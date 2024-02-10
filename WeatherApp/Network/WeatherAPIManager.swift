//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import Foundation

class WeatherAPIManager {
    
    static let shared = WeatherAPIManager()
    
    func request<T: Decodable>(type: T.Type, completionHandler: @escaping (T) -> Void) {
        let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37.654165&lon=127.049696" + "&appid=\(APIKey.openWeatherAPIKey)")!
        
        let url = URLRequest(url: baseUrl)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print("네트워크 통신 실패: error 발생")
                return
            }
            
            guard let data = data else {
                print("통신 성공, 데이터 안옴")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("통신 성공, 응답값이 오지 않음")
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("올바른 응답값이 아님")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type, from: data)
                dump(result)
            } catch {
                
            }
            
        }.resume()
        
    }
    
}

