//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import Foundation

enum APIError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class WeatherAPIManager {
    
    static let shared = WeatherAPIManager()
    
    func request<T: Decodable>(type: T.Type, api: WeatherAPI, completionHandler: @escaping (T?, APIError?) -> Void) {
        
        let url = URLRequest(url: api.endpoint)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print("네트워크 통신 실패: error 발생")
                completionHandler(nil, .failedRequest)
                return
            }
            
            guard let data = data else {
                print("통신 성공, 데이터 안옴")
                completionHandler(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("통신 성공, 응답값이 오지 않음")
                completionHandler(nil, .invalidResponse)
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("올바른 응답값이 아님")
                completionHandler(nil, .invalidResponse)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type, from: data)
                completionHandler(result, nil)
            } catch {
                print(error)
                completionHandler(nil, .invalidData)
            }
            
        }.resume()
        
    }
    
}

