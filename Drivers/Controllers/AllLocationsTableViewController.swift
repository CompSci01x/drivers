//
//  SampleTableViewController.swift
//  Drivers
//
//  Created by Spruce Tree on 11/14/21.
//

import UIKit

class AllLocationsTableViewController: UITableViewController {

    private var allLocationsDataSource = AllLocationsDataSource()

    func updateNearbyLocationsData(nearbyLocations: [NearbyLocation]) {
        self.allLocationsDataSource.setNearbyLocations(nearbyLocations: nearbyLocations)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = allLocationsDataSource
        tableView.backgroundColor = .systemGroupedBackground
        
        title = "All Locations"
        isModalInPresentation = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneClicked))
    }

    @objc private func doneClicked() {
        dismiss(animated: true)
    }

}
