//
//  CitiesListViewController.swift
//  AirQuality-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    var countryLanding: String?
    var statesLanding: String?
    var cities: [String]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.title = self.statesLanding
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
        guard let country = countryLanding, let state = statesLanding else { return }
        JDCCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cities) in
            self.cities = cities
        }
    }
    
    // MARK: - datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        
        cell.textLabel?.text = cities?[indexPath.row]
        
        return cell
    }
    
    // MARK: - navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "
    }
}
