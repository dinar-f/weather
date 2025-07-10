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

final class HomeViewController: BaseViewController {
    private var backgroundImage = UIImageView()
    private let viewModel = HomeViewModel()
    var dayTime: DayTime?
    weak var delegate : HomeViewControllerDelegate?
    let userDefault = UserDefaultManager.shared
    
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
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        button.addTarget(self, action: #selector (openSearchView), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        setupLayuot()
        getDayTime()
        getBackgroundImage()
        getCurrentCityInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserLocation()
    }
    
    @objc private func openSearchView() {
        let searchVC = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchVC)
        searchVC.delegate = self
        present(navigationController, animated: true, completion: nil)
    }
    
//    func saveCurrentCityInfo(city: String, temperature: String) {
//        UserDefaultManager.shared.saveValue(city, forKey: "CityName")
//        UserDefaultManager.shared.saveValue(temperature, forKey: "CityTemp")
//    }
    
    func saveCurrentCityInfo(city: String, temperature: String) {
        CoreDataManager.shared?.createEntity(entityType: CurrentCityInfo.self) { cityInfo in
            cityInfo.name = city
            cityInfo.temperature = temperature
        }
    }

    private func getCurrentCityInfo() {
        let cityInfoArray = CoreDataManager.shared?.fetchEntities(entityType: CurrentCityInfo.self)
        guard let cityInfo = cityInfoArray?.first,
              let city = cityInfo.name,
              let temp = cityInfo.temperature else { return }
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
    
    private func fetchUserLocation() {
        viewModel.getMainWeather(){ result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch result {
                case .success:
                    if let weatherInfo = self.viewModel.weatherInfo {
                        self.addWeatherDislaying(weatherInfo: weatherInfo)
                        saveCurrentCityInfo(city: weatherInfo.cityName, temperature: weatherInfo.temperature)
                        if let location = self.viewModel.location {
                            self.delegate?.updateLocation(latitude: location.latitude, longitude: location.longitude)
                        }
                    }
                case .failure(let error):
                    self.showAlert(title: "Error", message: "\(error.localizedDescription)")
                }
            }
        }
    }
    
    private func bindViews() {
        view.addSubviews(
            backgroundImage,
            citylabel,
            cityTemp,
            feeling,
            searchButton)
    }
    
    private func getBackgroundImage() {
        switch dayTime {
        case .morning:
            backgroundImage.image = UIImage(named: dayTime?.rawValue ?? "")
        case .sun:
            backgroundImage.image = UIImage(named: dayTime?.rawValue ?? "")
        default:
            backgroundImage.image = UIImage(named: dayTime?.rawValue ?? "")
        }
    }
    
    private func getDayTime() {
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
    
    private func setupLayuot() {
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
