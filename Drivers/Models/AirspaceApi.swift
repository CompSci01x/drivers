//
//  AirspaceApi.swift
//  Drivers
//
//  Created by Spruce Tree on 11/14/21.
//

import Foundation

struct AirspaceApi: Decodable {
    
    let nearbyLocations: [NearbyLocation]?
    
    enum CodingKeys: String, CodingKey {
        case nearby_locations = "nearby_locations"
    }
    
    // Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nearbyLocations = try container.decode([NearbyLocation].self, forKey: .nearby_locations)
    }
    
}

