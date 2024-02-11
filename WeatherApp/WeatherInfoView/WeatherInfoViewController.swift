//
//  ViewController.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import UIKit
import Kingfisher
import SkeletonView

class WeatherInfoViewController: BaseViewController {
    
    let mainView = WeatherInfoView()
    
    var weatherForecast: [Weather] = []
    var location = City(name: "")
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }
    
    override func configureView() {
        mainView.searchCityButton.addTarget(self, action: #selector(searchCityButtonClicked) , for: .touchUpInside)
    }

    @objc
    private func searchCityButtonClicked() {
        let vc = SearchCityViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WeatherInfoViewController {
    
    private func callAPI() {
        
        let group = DispatchGroup()
        
        group.enter()
        WeatherAPIManager.shared.request(type: WeatherForecast.self, api: WeatherAPI.forecase5(city: "seoul")) { data, error  in
            
            if error == nil {
                guard let data = data else { return }
                self.weatherForecast = data.list
                self.location = data.city
                group.leave()
            }
            
        }
        
        group.notify(queue: .main) {
            self.setViewData()
        }
    }
    
    private func setViewData() {
        mainView.location.hideSkeleton(transition: .crossDissolve(0.25))
        mainView.currentTemperature.hideSkeleton(transition: .crossDissolve(0.25))
        guard let first = weatherForecast.first else { return }
        mainView.location.text = location.name
        mainView.currentTemperature.text = "\(first.main.celsiusTemperature)°"
        
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

