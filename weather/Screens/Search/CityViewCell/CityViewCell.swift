//
//  CityViewCell.swift
//  weather
//
//  Created by Dinar on 08.12.2024.
//

import UIKit
import SnapKit

class CityViewCell: UITableViewCell  {
    
    var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    var regionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bindViews()
        setupLayuot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViews() {
        addSubview(cityNameLabel)
        addSubview(regionLabel)
    }
    
    func setupLayuot() {
        cityNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(28)
            make.centerY.equalTo(contentView)
        }
        regionLabel.snp.makeConstraints { make in
            make.leading.equalTo(cityNameLabel.snp.trailing).offset(20)
            make.top.equalTo(cityNameLabel.snp.top).offset(6)
        }
    }
}

