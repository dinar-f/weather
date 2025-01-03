//
//  Forecast+CollectionView.swift
//  weather
//
//  Created by Dinar on 13.12.2024.
//

import UIKit

extension ForecastViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.forecastsList.count - 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as? ForecastCell else { return
                UICollectionViewCell()}
            cell.configureCell(forecast: viewModel.forecastsList[0])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as? ForecastCell else { return
                UICollectionViewCell()}
            let forecastIndex = indexPath.item + 1
            cell.configureCell(forecast: viewModel.forecastsList[forecastIndex])
            return cell
        }
    }
}

