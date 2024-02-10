//
//  ViewController.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherAPIManager.shared.request(type: WeatherResult.self) { data in
            dump(data)
        }
    }


}

