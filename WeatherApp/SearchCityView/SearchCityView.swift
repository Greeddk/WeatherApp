//
//  SearchCityView.swift
//  WeatherApp
//
//  Created by Greed on 2/11/24.
//

import UIKit
import SnapKit

final class SearchCityView: BaseView {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubviews([tableView])
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
}
