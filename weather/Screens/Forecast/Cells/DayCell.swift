//
//  DayCell.swift
//  weather
//
//  Created by Dinar on 22.12.2024.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViews()
        setupViews()
        layer.borderColor = UIColor.black.cgColor
               layer.borderWidth = 1.0
               layer.cornerRadius = 8.0 
               layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(forecast: ForecastInfo) {
        dateLabel.text = forecast.weekDay
        tempLabel.text = forecast.maxTemp
    }
    
    func bindViews() {
        addSubview(dateLabel)
        addSubview(tempLabel)
    }
    
    private func setupViews() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
    }
}
