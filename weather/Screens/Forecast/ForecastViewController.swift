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

extension ForecastViewController: HomeViewControllerDelegate {
    func updateLocation(latitude: Double, longitude: Double) {
        viewModel.getforecast(latitude: latitude, longitude: longitude) { [weak self] result in
            self?.collectionView.reloadData()
        }
    }
}
