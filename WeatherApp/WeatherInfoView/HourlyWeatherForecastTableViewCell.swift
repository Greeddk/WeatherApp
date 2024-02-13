//
//  HourlyWeatherForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Greed on 2/13/24.
//

import UIKit

class HourlyWeatherForecastTableViewCell: BaseTableViewCell {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())

    override func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 60, height: 140)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
