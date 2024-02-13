//
//  HourlyWeatherForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Greed on 2/11/24.
//

import UIKit
import SnapKit

final class HourlyWeatherForecastCollectionViewCell: BaseCollectionViewCell {
    
    let timeLabel = UILabel()
    let weatherImage = UIImageView()
    let temperatureLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubviews([timeLabel, weatherImage, temperatureLabel])
    }
    
    override func configureLayout() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(contentView)
        }
        
        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(16)
            make.size.equalTo(32)
            make.centerX.equalTo(contentView)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp.bottom).offset(16)
            make.centerX.equalTo(contentView)
        }
    }
    
}
