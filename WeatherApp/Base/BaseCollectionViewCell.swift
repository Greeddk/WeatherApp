//
//  BaseCollectionViewCell.swift
//  WeatherApp
//
//  Created by Greed on 2/11/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, Codebase {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }
}
