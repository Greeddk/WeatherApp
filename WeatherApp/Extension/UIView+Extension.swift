//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by Greed on 2/11/24.
//

import UIKit

extension UIView {
    func addSubviews(_ Views: [UIView]) {
        Views.forEach { addSubview($0) }
    }
}
