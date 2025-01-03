//
//  ForecastViewController.swift
//  weather
//
//  Created by Dinar on 12.12.2024.
//

import UIKit
import SnapKit

class ForecastViewController: BaseViewController {
    let viewModel =  ForecastViewModel()
    weak var delegate: HomeViewControllerDelegate?
    
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
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: "ForecastCell")
        collectionView.collectionViewLayout = createlayout()
    }
    
    func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }
    
    private func createForecastSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }
}

extension ForecastViewController: HomeViewControllerDelegate {
    func updateLocation(latitude: Double, longitude: Double) {
        viewModel.getforecast(latitude: latitude, longitude: longitude) { [weak self] result in
            self?.collectionView.reloadData()
        }
    }
}
