//
//  Search+TableView.swift
//  weather
//
//  Created by Dinar on 10.12.2024.
//

import UIKit

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.citiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityViewCell else { return UITableViewCell()}
        let cityItem = viewModel.citiesList[indexPath.row]
        cell.configure(cityInfo: cityItem)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = viewModel.citiesList[indexPath.row]
        delegate?.didSelectCity(latitude: selectedCity.latitude, longitude: selectedCity.longitude)
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
}
