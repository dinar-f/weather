//
//  ForecastViewCell.swift
//  weather
//
//  Created by Dinar on 18.12.2024.
//

import UIKit

class ForecastViewCell: UICollectionViewCell {
    
    var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    func configureCell(forecast: ForecastInfo) {
        dayOfWeekLabel.text = forecast.weekDay
        tempLabel.text = forecast.maxTemp
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViews()
        setupLayuot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViews(){
        addSubview(dayOfWeekLabel)
        addSubview(tempLabel)
    }
    
    func setupLayuot(){
        dayOfWeekLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dayOfWeekLabel.snp.bottom).offset(10)
        }
    }
}

