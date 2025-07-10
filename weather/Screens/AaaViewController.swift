//
//  AaaViewController.swift
//  weather
//
//  Created by Dinar on 27.03.2025.
//

import Foundation

import UIKit

final class CategoryView: UIView {
    
    private var categoriesList: [Categories] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.montserratRegular(with: 20)
        label.text = "Category"
        label.textAlignment = .center
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addSubviews()
        setupLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCategories(_ categories: [Categories]) {
        self.categoriesList = categories
        collectionView.reloadData()
    }
}


private extension CategoryView {
    
    func configureView() {
        backgroundColor = .white
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(collectionView)
        collectionView.register(CategoryCell.self,
                                forCellWithReuseIdentifier: CategoryCell.id)
    }
    
    func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 126),
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension CategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        
        let category = categoriesList[indexPath.item]
        cell.configureCell(with: category)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CategoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 4
        let padding: CGFloat = 10
        let totalSpacing = (itemsPerRow - 1) * padding
        let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
        
        return CGSize(width: itemWidth - 5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 18, bottom: 0, right: 18)
    }
}
