//
//  ViewController.swift
//  weather
//
//  Created by Dinar on 16.11.2024.
//

import UIKit
import SnapKit


class TabBarController:UITabBarController {
    private let customTabBar = CustomTabBar()
    
    let circularTabButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 46 / 2
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(didTapCircularTabButton), for: .touchUpInside)
        return button
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .green
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setValue(customTabBar, forKey: "tabBar")
        setTabBarItems()
        setupCircularTabButton()
    }
    
    func setTabBarItems(){
        let homeViewController = HomeViewController()
        homeViewController.title = "Home"
        homeViewController.tabBarItem.image = UIImage(systemName: "house.fill")
        
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.title = "Favorite"
        
        let forecastViewController = ForecastViewController()
        forecastViewController.title = "Forecast"
        forecastViewController.tabBarItem.image = UIImage(systemName: "person.fill")
        
        homeViewController.delegate = forecastViewController
        
        viewControllers = [homeViewController, favoriteViewController, forecastViewController]
    }
    
    func setupCircularTabButton() {
        tabBar.addSubview(circularTabButton)
        tabBar.addSubview(iconImageView)
        
        circularTabButton.snp.makeConstraints { make in
            make.centerX.equalTo(tabBar)
            make.centerY.equalTo(tabBar).offset(-30)
            make.width.height.equalTo(46)
        }
        iconImageView.snp.makeConstraints { make in
            make.center.equalTo(circularTabButton)
            make.width.height.equalTo(18)
        }
    }
    
    @objc private func didTapCircularTabButton() {
        print("tap")
        self.selectedIndex = 1
    }
}
