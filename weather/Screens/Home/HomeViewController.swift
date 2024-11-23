//
//  HomeController.swift
//  weather
//
//  Created by Dinar on 16.11.2024.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController{
    var backgroundImage = UIImageView()
    private let viewModel = HomeViewModel()
    var dayTime: DayTime?
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    var locationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Location", for: .normal)
        button.addTarget(self, action: #selector (fetchUserLocation), for: .touchUpInside)
        return button
    }()
    
    var citylabel: UILabel = {
        let label = UILabel()
        label.text = "CityName"
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    var cityTemp: UILabel = {
        let label = UILabel()
        label.text="30°C"
        label.textColor = .black
        label.font = .systemFont(ofSize: 60)
        return label
    }()
    
    var feeling: UILabel = {
        let label = UILabel()
        label.text = "Rain"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        button.addTarget(self, action: #selector (openSearchView), for: .touchUpInside)
        return button
    }()
    
    @objc private func openSearchView() {
        let searchVC = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchVC)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func fetchUserLocation() {
        viewModel.requestLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        setupLayuot()
        getDayTime()
        getBackgroundImage()
        viewModel.locationUpdate = { result in
            switch result {
            case .success(let coordinates):
                self.locationLabel.text = ("\(coordinates.0),\(coordinates.1)")
            case .failure(let error):
                self.locationLabel.text = error.localizedDescription
            }
        }
    }
    
    func bindViews() {
        view.addSubview(backgroundImage)
        view.addSubview(citylabel)
        view.addSubview(cityTemp)
        view.addSubview(feeling)
        view.addSubview(searchButton)
        view.addSubview(locationButton)
        view.addSubview(locationLabel)
    }
    
    func getBackgroundImage() {
        switch dayTime {
        case .morning:
            backgroundImage.image = UIImage(named: dayTime?.rawValue ?? "")
        case .sun:
            backgroundImage.image = UIImage(named: dayTime?.rawValue ?? "")
        default:
            backgroundImage.image = UIImage(named: dayTime?.rawValue ?? "")
        }
    }
    
    func getDayTime() {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0...11:
            dayTime = .morning
        case 12...17:
            dayTime = .sun
        default:
            dayTime = .night
        }
    }
    
    func setupLayuot() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        citylabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(240)
        }
        cityTemp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(citylabel).inset(80)
        }
        feeling.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityTemp.snp.bottom).offset(4)
        }
        searchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(50)
            make.top.equalToSuperview().offset(100)
            make.height.width.equalTo(40)
        }
        locationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(160)
        }
        locationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
    }
}

