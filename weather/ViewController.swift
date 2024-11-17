//
//  ViewController.swift
//  weather
//
//  Created by Dinar on 16.11.2024.
//

import UIKit
import SnapKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addTabBar()
        setupTabBar()
    }
    
    func addTabBar() {
        viewControllers = [
            generateViewContoller(
                viewController: HomeViewController(),
                title: "Main",
                image: UIImage(systemName: "house.fill")
            ),
            generateViewContoller(
                viewController: DescriptionViewController(),
                title: "Description",
                image: UIImage(systemName: "description.fill")
            )]
    }
    
    func generateViewContoller(viewController: UIViewController,title: String,image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.barTintColor = .white
    }
}

