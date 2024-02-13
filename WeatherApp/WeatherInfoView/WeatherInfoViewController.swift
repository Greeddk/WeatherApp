//
//  ViewController.swift
//  WeatherApp
//
//  Created by Greed on 2/10/24.
//

import UIKit
import Kingfisher
import SkeletonView

final class WeatherInfoViewController: BaseViewController {
    
    let mainView = WeatherInfoView()
    
    var weatherForecast: [Weather] = []
    var location = City(name: "")
    var dailyWeatherList: [DailyWeather] = []
    
    let sectionTitles = ["", "3시간 간격의 일기예보", "5일 간의 일기예보"]
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func configureView() {
        mainView.searchCityButton.addTarget(self, action: #selector(searchCityButtonClicked) , for: .touchUpInside)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(HourlyWeatherForecastTableViewCell.self, forCellReuseIdentifier: HourlyWeatherForecastTableViewCell.identifier)
        mainView.tableView.register(DailyWeatherForecastTableViewCell.self, forCellReuseIdentifier: DailyWeatherForecastTableViewCell.identifier)
    }

    @objc
    private func searchCityButtonClicked() {
        let vc = SearchCityViewController()
        vc.cityData = { city in
            self.callAPI(id: city.id)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WeatherInfoViewController {
    
    private func callAPI() {
        
        let group = DispatchGroup()
        
        group.enter()
        WeatherAPIManager.shared.request(type: WeatherForecast.self, api: WeatherAPI.forecast5(city: "seoul")) { data, error  in
            
            if error == nil {
                guard let data = data else { return }
                self.weatherForecast = data.list
                self.set5Days(data)
                self.location = data.city
                group.leave()
            }
            
        }
        
        group.notify(queue: .main) {
            self.setViewData()
            self.mainView.tableView.reloadData()
        }
    }
    
    private func callAPI(id: Int) {
        let group = DispatchGroup()
        
        group.enter()
        WeatherAPIManager.shared.request(type: WeatherForecast.self, api: WeatherAPI.cityWeatherforecast5(id: id)) { data, error  in
            
            if error == nil {
                guard let data = data else { return }
                self.weatherForecast = data.list
                self.dailyWeatherList = []
                self.set5Days(data)
                self.location = data.city
                group.leave()
            }
            
        }
        
        group.notify(queue: .main) {
            self.setViewData()
            self.mainView.tableView.reloadData()
        }
    }
    
    private func setViewData() {
        mainView.location.hideSkeleton(transition: .crossDissolve(0.25))
        mainView.currentTemperature.hideSkeleton(transition: .crossDissolve(0.25))
       
        mainView.location.text = location.name
        guard let first = weatherForecast.first else { return }
        mainView.currentTemperature.text = " \(first.main.celsiusTemperature)"
        mainView.weatherStatus.text = first.weather.first?.description
    }
    
    private func changeDateFormatToDay(text: String) -> String {
        let originFormat = DateFormatter()
        originFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let data = originFormat.date(from: text) else { return "format Error" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEEE"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        let result = dateFormatter.string(from: data)
        
        let now = Date()
        let today = dateFormatter.string(from: now)
        
        if today == result {
            return "오늘"
        } else {
            return result
        }
        
    }
    
    private func changeDateFormatToTime(text: String) -> String {
        let originFormat = DateFormatter()
        originFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let data = originFormat.date(from: text) else { return "format Error" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let result = dateFormatter.string(from: data)
        
        return result + "시"
    }
    
    private func set5Days(_ list: WeatherForecast) {
        var temp: [String] = []
        for index in list.list {
            let day = changeDateFormatToDay(text: index.dt_txt)
            if !temp.contains(day) {
                temp.append(day)
                dailyWeatherList.append(DailyWeather(day: day, icon: index.weather.first?.icon ?? "", temp_min: index.main.temp_min, temp_max: index.main.temp_max))
            } else {
                let last = dailyWeatherList[dailyWeatherList.count - 1]
//                if last.minTemp > index.main.temp_min {
//                    dailyWeatherList[dailyWeatherList.count - 1].minTemp = index.main.temp_min
//                }
//                if last.maxTemp < index.main.temp_max {
//                    dailyWeatherList[dailyWeatherList.count - 1].maxTemp = index.main.temp_max
//                }
//                guard let icon = index.weather.first?.icon else { return }
//                if last.icon < icon {
//                    dailyWeatherList[dailyWeatherList.count - 1].icon = icon
//                }
                // ???: 왜 last.maxtTemp = last....삼항연산은 안되는가?? // 값이 왜 들어가지 않는가?
                dailyWeatherList[dailyWeatherList.count - 1].temp_max = last.temp_max > index.main.temp_max ? last.temp_max : index.main.temp_max
                dailyWeatherList[dailyWeatherList.count - 1].temp_min = last.temp_min < index.main.temp_min ? last.temp_min : index.main.temp_min
                guard let icon = index.weather.first?.icon else { return }
                dailyWeatherList[dailyWeatherList.count - 1].icon = last.icon > icon ? last.icon : icon
            }
        }
    }
    
}

extension WeatherInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dailyWeatherList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherForecastTableViewCell.identifier, for: indexPath) as! HourlyWeatherForecastTableViewCell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(HourlyWeatherForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherForecastCollectionViewCell.identifier)
            cell.collectionView.showsHorizontalScrollIndicator = false
            cell.collectionView.reloadData()
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherForecastTableViewCell.identifier, for: indexPath) as! DailyWeatherForecastTableViewCell
            if !weatherForecast.isEmpty {
                cell.dayLabel.text = dailyWeatherList[indexPath.row].day
                let url = WeatherAPI.icon(id: dailyWeatherList[indexPath.row].icon).endpoint
                cell.weatherIcon.kf.setImage(with: url)
                cell.maxTemp.text = "\(dailyWeatherList[indexPath.row].maxTemp)"
                cell.minTemp.text = "\(dailyWeatherList[indexPath.row].minTemp)"
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return 50
        }
    }
    
}

extension WeatherInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherForecastCollectionViewCell.identifier, for: indexPath) as! HourlyWeatherForecastCollectionViewCell
        cell.timeLabel.text = changeDateFormatToTime(text: weatherForecast[indexPath.item].dt_txt)
        let url = WeatherAPI.icon(id: weatherForecast[indexPath.item].weather.first?.icon ?? "").endpoint
        cell.weatherImage.kf.setImage(with: url)
        cell.temperatureLabel.text = "\(weatherForecast[indexPath.item].main.roundedTemp)"
        
        return cell
    }
    
}

