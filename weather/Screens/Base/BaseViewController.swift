//
//  BaseViewController.swift
//  weather
//
//  Created by Dinar on 10.12.2024.
//
import UIKit


class BaseViewController: UIViewController {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
