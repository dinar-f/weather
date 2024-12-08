//
//  SearchViewController.swift
//  weather
//
//  Created by Dinar on 17.11.2024.
//

import UIKit
import SnapKit

protocol SearchViewControllerDelegate: AnyObject {
    func didSelectCity(latitude: Double, longitude: Double)
}

class SearchViewController: UIViewController {
    private let viewModel = SearchViewModel()
    weak var delegate : SearchViewControllerDelegate?
    
    var citiesList: [CityInfo] = []
    var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var citySearchInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Search"
        input.borderStyle = .roundedRect
        input.textColor = .black
        input.backgroundColor = .white
        input.layer.borderWidth = 1
        input.layer.cornerRadius = 5
        input.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        return input
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .center
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    @objc func textFieldChange(_ textField: UITextField){
        let text = textField.text ?? ""
        viewModel.getCitiesList(cityName: text){ result in
            switch result {
            case .success(let cities):
                self.citiesList = cities
                if self.citiesList.isEmpty && !text.isEmpty {
                    self.showMessage(message: "Не найдено совпадений")
                } else {
                    self.messageLabel.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            case .failure:
                AlertModalView.showAlert(on: self, title: "Error", message: "Ошибка получения данных. Пожалуйста, попробуйте снова")
            }
        }
    }
    
    private func showMessage(message: String) {
        messageLabel.text = message
        messageLabel.isHidden = false
        tableView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindViews()
        setupLayuot()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityViewCell.self, forCellReuseIdentifier: "CityCell")
    }
    
    func bindViews() {
        view.addSubview(citySearchInput)
        view.addSubview(tableView)
        view.addSubview(messageLabel)
    }
    
    func setupLayuot() {
        citySearchInput.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(25)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(60)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(citySearchInput.snp.bottom).offset(20)
        }
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(citySearchInput.snp.bottom).offset(40)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityViewCell
        let cityItem = citiesList[indexPath.row]
        cell.cityNameLabel.text = cityItem.cityName
        cell.regionLabel.text = cityItem.region
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = citiesList[indexPath.row]
        delegate?.didSelectCity(latitude: selectedCity.latitude, longitude: selectedCity.longitude)
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
}

