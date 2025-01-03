//
//  ForecastCell.swift
//  weather
//
//  Created by Dinar on 03.01.2025.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        return label
    }()
    
    private let weatherIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViews()
        setupViews()
        layer.borderColor = UIColor.black.cgColor
               layer.borderWidth = 1.0
               layer.cornerRadius = 8.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(forecast: ForecastInfo) {
        timeLabel.text = forecast.time
        dateLabel.text = forecast.weekDay
        tempLabel.text = "\(forecast.temp)°C"
        weatherIcon.image = UIImage(named: forecast.icon)
    }
    
    func bindViews() {
        addSubview(timeLabel)
        addSubview(dateLabel)
        addSubview(tempLabel)
        addSubview(weatherIcon)
    }
    
    private func setupViews() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalToSuperview().offset(15)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.leading.equalToSuperview().offset(15)
        }
        weatherIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalTo(timeLabel.snp.trailing).offset(10)
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(15)
        }
    }
}
