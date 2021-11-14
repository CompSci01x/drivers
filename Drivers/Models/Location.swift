//
//  Location.swift
//  Drivers
//
//  Created by Spruce Tree on 11/14/21.
//

import Foundation

struct Location: Codable {
    
    let driver_session_id: Int?
    let driver_id: Int?
    
    let latitude: Double?
    let longitude: Double?
    let altitude: Double?
    
    let created_at: String?
    
    init() {
        latitude = 0
        longitude = 0
        driver_id = nil
        driver_session_id = nil
        altitude = nil
        created_at = nil
    }
    
}
