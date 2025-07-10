//
//  UIView+Extension.swift
//  weather
//
//  Created by Dinar on 05.01.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach({ element in
            addSubview(element)
        })
    }
}
