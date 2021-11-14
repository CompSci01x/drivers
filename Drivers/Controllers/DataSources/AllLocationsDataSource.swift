//
//  AllLocationsDataSource.swift
//  Drivers
//
//  Created by Spruce Tree on 11/14/21.
//

import Foundation
import UIKit

class AllLocationsDataSource: NSObject, UITableViewDataSource {
    
    private var nearbyLocations: [NearbyLocation] = []
    
    func setNearbyLocations(nearbyLocations: [NearbyLocation]) {
        self.nearbyLocations = nearbyLocations
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return nearbyLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? LocationDetailTableViewCell else {
            fatalError("unable to dequeue detailCell")
        }

        if let theLocation = nearbyLocations[indexPath.section].location {
            
            if indexPath.row == 0 {
                cell.titleLabel.text = "driver_session_id"

                if theLocation.driver_session_id != nil {
                    cell.valueLabel.text = "\(theLocation.driver_session_id!)"
                }
                else if theLocation.driver_id != nil {
                    cell.titleLabel.text = "driver_id"
                    cell.valueLabel.text = "\(theLocation.driver_id!)"
                }
                else {
                    cell.valueLabel.text = "N/A"
                }
            }
            else if indexPath.row == 1 {
                cell.titleLabel.text = "created_at"
                
                if theLocation.created_at != nil {
                    cell.valueLabel.text = "\(theLocation.created_at!.formatDate())"
                }
                else {
                    cell.valueLabel.text = "N/A"
                }
            }
            else if indexPath.row == 2 {
                cell.titleLabel.text = "latitude"
                
                if theLocation.latitude != nil {
                    cell.valueLabel.text = "\(theLocation.latitude!)"
                }
                else {
                    cell.valueLabel.text = "N/A"
                }
            }
            else if indexPath.row == 3 {
                cell.titleLabel.text = "longitude"
                
                if theLocation.longitude != nil {
                    cell.valueLabel.text = "\(theLocation.longitude!)"
                }
                else {
                    cell.valueLabel.text = "N/A"
                }
            }
            else if indexPath.row == 4 {
                cell.titleLabel.text = "dist"
                
                if nearbyLocations[indexPath.section].dist != nil {
                    cell.valueLabel.text = "\(nearbyLocations[indexPath.section].dist!)"
                }
                else {
                    cell.valueLabel.text = "N/A"
                }
            }
        }
        
        return cell
    }
    
    
    
}
