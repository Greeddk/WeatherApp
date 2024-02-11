//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Greed on 2/11/24.
//

import UIKit
import SnapKit

class WeatherInfoView: BaseView {
    
    let location = UILabel()
    let currentTemperature = UILabel()
    let weatherImage = UIImageView()
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubviews([location ,currentTemperature, weatherImage, tableView])
    }
    
    override func configureLayout() {
        location.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(location.snp.bottom).offset(10)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(150)
        }
        
        currentTemperature.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp.bottom).offset(8)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(currentTemperature.snp.bottom).offset(40)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
