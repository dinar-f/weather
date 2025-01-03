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

class SearchViewController: BaseViewController {
    let viewModel = SearchViewModel()
    weak var delegate : SearchViewControllerDelegate?
    
    var tableView = UITableView()
    
    var citySearchInput: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search your city"
        searchBar.searchBarStyle = .default
        return searchBar
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
        citySearchInput.delegate = self
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

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getCitiesList(cityName: searchText) { result in
            switch result {
            case .success(let cities):
                if cities.isEmpty && !searchText.isEmpty {
                    self.showMessage(message: "Не найдено совпадений")
                } else {
                    self.messageLabel.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            case .failure:
                self.showAlert(title: "Error", message: "Ошибка получения данных. Пожалуйста, попробуйте снова")
            }
        }
    }
}


