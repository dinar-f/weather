//
//  ForecastViewController.swift
//  weather
//
//  Created by Dinar on 12.12.2024.
//

import UIKit
import SnapKit

class ForecastViewController: UIViewController {
    private let viewModel =  ForecastViewModel()
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        setupLayuot()
        collectionView.dataSource = self
        collectionView.register(ForecastViewCell.self, forCellWithReuseIdentifier: "ForecastViewCell")
    }
    
    func fetchForecastWeather() {
        viewModel.getforecast(latitude: 37.7858, longitude: -122.4064){ result in
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchForecastWeather()
    }
    
    func bindViews() {
        view.addSubview(collectionView)
    }
    
    func setupLayuot() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}

extension ForecastViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.forecastsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastViewCell", for: indexPath) as? ForecastViewCell else { return UICollectionViewCell() }
        
        let forecastItem = viewModel.forecastsList[indexPath.row]
        cell.configureCell(forecast: forecastItem)
        return cell
    }
}
