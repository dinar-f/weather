//
//  HomeController.swift
//  weather
//
//  Created by Dinar on 16.11.2024.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController{
    var backgroundImage = UIImageView()
    
    var citylabel: UILabel = {
        let label = UILabel()
        
        label.text="CityName"
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var cityTemp: UILabel = {
        let label = UILabel()
        
        label.text="30°C"
        label.textColor = .black
        label.font = .systemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
        
    var feeling: UILabel = {
        let label = UILabel()
        
        label.text="Rain"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var searchButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "search"), for: .normal)
        button.addTarget(self, action: #selector (openSearchView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        setupLayuot()
        getBackgroundImage()
    }
    
    func bindViews() {
        view.addSubview(backgroundImage)
        view.addSubview(citylabel)
        view.addSubview(cityTemp)
        view.addSubview(feeling)
        view.addSubview(searchButton)
    }
    
    @objc private func openSearchView() {
        let searchVC = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchVC)
        present(navigationController, animated: true, completion: nil)
        }
    
    func getBackgroundImage() {
            let hour = Calendar.current.component(.hour, from: Date())
            
            switch hour {
            case 6..<12:
                backgroundImage.image = UIImage(named: "morning")
            case 12..<18:
                backgroundImage.image = UIImage(named: "sun")
            default:
                backgroundImage.image = UIImage(named: "night")
            }
        }
    
    func setupLayuot() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        citylabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(240)
        }
        cityTemp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(citylabel).inset(80)
        }
        feeling.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityTemp.snp.bottom).offset(4)
        }
        searchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(50)
            make.top.equalToSuperview().offset(100)
            make.height.width.equalTo(40)
        }
    }
}

