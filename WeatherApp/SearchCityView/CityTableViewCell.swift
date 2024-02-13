//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Greed on 2/11/24.
//

import UIKit
import SnapKit

final class CityTableViewCell: BaseTableViewCell {
    
    let cityName = UILabel()
    let country = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubviews([cityName, country])
    }
    
    override func configureLayout() {
        cityName.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
        
        country.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom).offset(2)
            make.leading.equalTo(cityName.snp.leading)
        }
    }
    
    override func configureView() {
        cityName.textColor = .white
        country.textColor = .white
    }

}
