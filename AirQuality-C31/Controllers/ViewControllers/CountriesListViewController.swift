//
//  CountriesListViewController.swift
//  AirQuality-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

import UIKit

class CountriesListViewController: UIViewController {
    
    // MARK: - Properties
    var countries: [String]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Countries"
        JDCCityAirQualityController.fetchSupportedCountries { (countries) in
            self.countries = countries
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource extension
extension CountriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        cell.textLabel?.text = countries?[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStatesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? StatesListViewController else { return }
            destinationVC.countryLanding = countries?[indexPath.row]
        }
    }
}
