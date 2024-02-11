//
//  DailyWeatherForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Greed on 2/11/24.
//

import UIKit

class DailyWeatherForecastTableViewCell: BaseTableViewCell {
    
    let dayLabel = UILabel()
    let weatherIcon = UIImageView()
    let minTemp = UILabel()
    let maxTemp = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([dayLabel, weatherIcon, minTemp, maxTemp])
    }
    
    override func configureLayout() {
        dayLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing).offset(20)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.size.equalTo(24)
        }
        
        minTemp.snp.makeConstraints { make in
            make.leading.equalTo(weatherIcon.snp.trailing).offset(20)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        maxTemp.snp.makeConstraints { make in
            make.leading.equalTo(minTemp.snp.trailing).offset(20)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        minTemp.textColor = .systemGray
        maxTemp.textColor = .white
    }
    
}
