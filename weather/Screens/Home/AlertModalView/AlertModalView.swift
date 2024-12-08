//
//  AlertModalView.swift
//  weather
//
//  Created by Dinar on 08.12.2024.
//

import UIKit

class AlertModalView {
    static func showAlert(on viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
}
