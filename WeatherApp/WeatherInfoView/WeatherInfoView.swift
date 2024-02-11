//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Greed on 2/11/24.
//

import UIKit
import SnapKit
import SkeletonView

class WeatherInfoView: BaseView {
    
    let location = UILabel()
    let currentTemperature = UILabel()
    let tableView = UITableView()
    let bottomView = UIView()
    let searchCityButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSkeleton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubviews([location, currentTemperature, tableView, bottomView, searchCityButton])
    }
    
    override func configureLayout() {
        location.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(100)
        }
        
        currentTemperature.snp.makeConstraints { make in
            make.top.equalTo(location.snp.bottom).offset(8)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(140)
            make.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(currentTemperature.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(self)
            make.height.equalTo(100)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        searchCityButton.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(10)
            make.trailing.equalTo(bottomView.snp.trailing).offset(-20)
        }
    }
    
    override func configureView() {
        location.textAlignment = .center
        location.font = .systemFont(ofSize: 30)
        currentTemperature.font = .systemFont(ofSize: 60)
        currentTemperature.textAlignment = .center
        bottomView.backgroundColor = .gray
        searchCityButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        searchCityButton.tintColor = .black
    }
    
    
}

extension WeatherInfoView {
    
    private func configureSkeleton() {
        location.isSkeletonable = true
        currentTemperature.isSkeletonable = true
        
        location.linesCornerRadius = 4
        location.skeletonTextLineHeight = .fixed(30)
        currentTemperature.linesCornerRadius = 4
        currentTemperature.skeletonTextLineHeight = .fixed(60)
        
        location.showAnimatedGradientSkeleton()
        currentTemperature.showAnimatedGradientSkeleton()
        let gradient = SkeletonGradient(baseColor: UIColor.peterRiver)
    }
}


