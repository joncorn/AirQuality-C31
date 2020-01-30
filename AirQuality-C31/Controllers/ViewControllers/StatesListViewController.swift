//
//  StatesListViewController.swift
//  AirQuality-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

import UIKit

class StatesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    var country: String?
    var states: [String]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.title = self.country
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
        guard let country = country else { return }
        JDCCityAirQualityController.fetchSupportedStates(inCountry: country) { (states) in
            self.states = states
        }
    }
    
    // MARK: - datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        
        cell.textLabel?.text = states?[indexPath.row]
        
        return cell
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCitiesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? CitiesListViewController else { return }
            destinationVC.country = country
            destinationVC.state = states?[indexPath.row]
        }
    }
}
