//
//  Reusable.swift
//  WeatherApp
//
//  Created by Greed on 2/11/24.
//

import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension UIView: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
