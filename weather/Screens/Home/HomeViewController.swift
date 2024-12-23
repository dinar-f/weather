//
//  HomeController.swift
//  weather
//
//  Created by Dinar on 16.11.2024.
//

import UIKit
import SnapKit

protocol HomeViewControllerDelegate: AnyObject {
    func updateLocation(latitude: Double, longitude: Double)
}

class HomeViewController: BaseViewController {
    var backgroundImage = UIImageView()
    private let viewModel = HomeViewModel()
    var dayTime: DayTime?
    let userDefaults = UserDefaultManager()
    weak var delegate : HomeViewControllerDelegate?
    
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
    
    private func fetchUserLocation() {
        viewModel.getMainWeather(){ result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .success:
                    if let weatherInfo = self.viewModel.weatherInfo {
                        self.addWeatherDislaying(weatherInfo: weatherInfo)
                        saveCurrentCityInfo(city: weatherInfo.cityName, temperature: weatherInfo.temperature)
                    }
                case .failure(let error):
                    self.showAlert(title: "Error", message: "\(error.localizedDescription)")
                }
            }
        }
    }
    
    @objc private func openSearchView() {
        let searchVC = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchVC)
        searchVC.delegate = self
        present(navigationController, animated: true, completion: nil)
    }
    
    func saveCurrentCityInfo(city: String, temperature: String) {
        userDefaults.saveValue(city, forKey: "CityName")
        userDefaults.saveValue(temperature, forKey: "CityTemp")
    }
    
    func getCurrentCityInfo() {
        let city: String? = userDefaults.getValue(forKey: "CityName")
        let temp: String? = userDefaults.getValue(forKey: "CityTemp")
        guard let city, let temp else { return }
        self.citylabel.isHidden = false
        self.citylabel.text = city
        self.cityTemp.isHidden = false
        self.cityTemp.text = "\(temp)°C"
    }
    
    private func addWeatherDislaying(weatherInfo: WeatherInfo) {
        self.citylabel.isHidden = false
        self.citylabel.text = weatherInfo.cityName
        self.cityTemp.isHidden = false
        self.cityTemp.text = "\(weatherInfo.temperature)°C"
        self.feeling.isHidden = false
        self.feeling.text = weatherInfo.condition
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        setupLayuot()
        getDayTime()
        getBackgroundImage()
        getCurrentCityInfo()
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

extension HomeViewController: SearchViewControllerDelegate {
    func didSelectCity(latitude: Double, longitude: Double) {
        viewModel.loadWeather(latitude: latitude, longitude: longitude) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    if let weatherInfo = self.viewModel.weatherInfo {
                        self.addWeatherDislaying(weatherInfo: weatherInfo)
                    }
                case .failure(let error):
                    self.showAlert(title: "Error", message: "\(error.localizedDescription)")
                }
            }
        }
    }
}
