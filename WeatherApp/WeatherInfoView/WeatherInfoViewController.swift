//
//  ViewController.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import UIKit
import Kingfisher

class WeatherInfoViewController: BaseViewController {
    
    let mainView = WeatherInfoView()
    
    var weatherForecast: [Weather] = []
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }

    override func configureView() {
        mainView.location.text = weatherForecast.first?.name
        mainView.currentTemperature.text = String(describing: weatherForecast.first?.main.celsiusTemperature)
        guard let id = weatherForecast.first?.weather.first?.id else { return }
        let url = WeatherAPI.icon(id: id).endpoint
        mainView.weatherImage.kf.setImage(with: url)
    }
}

extension WeatherInfoViewController {
    
    private func callAPI() {
        WeatherAPIManager.shared.request(type: WeatherForecast.self, api: WeatherAPI.forecase5(city: "seoul")) { data, error  in
            
            if error == nil {
                guard let data = data else { return }
                self.weatherForecast = data.list
            }
            
        }
    }
    
}

//extension WeatherInfoViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell =
//    }
//    
//}

