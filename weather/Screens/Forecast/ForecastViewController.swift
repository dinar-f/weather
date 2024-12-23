//
//  ForecastViewController.swift
//  weather
//
//  Created by Dinar on 12.12.2024.
//

import UIKit
import SnapKit

class ForecastViewController: BaseViewController {
    private let viewModel =  ForecastViewModel()
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        setupLayuot()
        setDelegates()
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "DayCell")
        collectionView.register(TomorrowCell.self, forCellWithReuseIdentifier: "TomorrowCell")
        collectionView.collectionViewLayout = createlayout()
    }
    
    func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
//    func fetchForecastWeather() {
//        viewModel.getforecast(latitude: 37.7858, longitude: -122.4064){ result in
//            self.collectionView.reloadData()
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

extension ForecastViewController {
    func createlayout() -> UICollectionViewCompositionalLayout{
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                return self.createTomorrowSection()
            } else {
                return self.createForecastSection()
            }
        }
        return layout
    }
    
    private func createTomorrowSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.6))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }
    
    private func createForecastSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }
}


extension ForecastViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TomorrowCell", for: indexPath) as? TomorrowCell else { return UICollectionViewCell() }
            if !viewModel.forecastsList.isEmpty {
                cell.configureCell(forecast: viewModel.forecastsList[0])
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell else { return UICollectionViewCell() }
            let forecastIndex = indexPath.item + 1
            if forecastIndex < viewModel.forecastsList.count {
                cell.configureCell(forecast: viewModel.forecastsList[forecastIndex])
            }
            return cell
        }
    }
}

extension ForecastViewController: HomeViewControllerDelegate {
    func updateLocation(latitude: Double, longitude: Double) {
        viewModel.getforecast(latitude: latitude, longitude: longitude){ result in
            self.collectionView.reloadData()
        }
    }
}
