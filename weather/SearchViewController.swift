//
//  SearchViewController.swift
//  weather
//
//  Created by Dinar on 17.11.2024.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
       var citySearchInput: UITextField = {
            let input = UITextField()
    
            input.placeholder = "Search"
            input.borderStyle = .roundedRect
            input.textColor = .black
            input.backgroundColor = .white
            input.layer.borderWidth = 1
            input.layer.cornerRadius = 5
            input.translatesAutoresizingMaskIntoConstraints = false
    
            return input
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            bindViews()
            setupLayuot()
        }
    
        func bindViews() {
            view.addSubview(citySearchInput)
        }
    
        func setupLayuot() {
            citySearchInput.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.top.equalToSuperview().offset(40)
                make.height.equalTo(60)
            }
          }
        }
