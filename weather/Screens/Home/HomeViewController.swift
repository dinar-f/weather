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
    
    var citylabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    var cityTemp: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .black
        label.font = .systemFont(ofSize: 60)
        return label
    }()
    
    var feeling: UILabel = {
        let label = UILabel()
        label.isHidden = true
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
    
    private func fetchUserLocation() {
        viewModel.loadWeather(){ result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    if let weatherInfo = self.viewModel.weatherInfo {
                        self.citylabel.isHidden = false
                        self.citylabel.text = weatherInfo.cityName
                        self.cityTemp.isHidden = false
                        self.cityTemp.text = "\(weatherInfo.temperature)°C"
                        self.feeling.isHidden = false
                        self.feeling.text = weatherInfo.condition
                    }
                case .failure(let error):
                    self.showAlertModal(title: "Eroor", message: "\(error.localizedDescription)")
                }
            }
        }
    }
    
    private func showAlertModal(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        setupLayuot()
        getDayTime()
        getBackgroundImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchUserLocation()
    }
    
    func bindViews() {
        view.addSubview(backgroundImage)
        view.addSubview(citylabel)
        view.addSubview(cityTemp)
        view.addSubview(feeling)
        view.addSubview(searchButton)
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
    }
}

