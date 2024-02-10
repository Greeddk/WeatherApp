//
//  ViewController.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import UIKit

class WeatherInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }

}

extension WeatherInfoViewController {
    
    private func callAPI() {
        WeatherAPIManager.shared.request(type: WeatherResult.self, api: WeatherAPI.currentWeather) { data, error  in

        }
    }
}

