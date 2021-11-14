//
//  MapPlotPoint.swift
//  Drivers
//
//  Created by Spruce Tree on 11/14/21.
//
import Foundation
import MapKit

class MapPlotPoint: NSObject, MKAnnotation {
    
    var location: Location
    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    var subtitle: String?
    
    init(location: Location) {
        
        self.location = location
        self.coordinate = CLLocationCoordinate2D(latitude: location.latitude!,
                                                 longitude: location.longitude!)
        
        if location.driver_session_id != nil && location.created_at != nil {
            self.title = String(format: "driver_sessions_id: %i", location.driver_session_id!)
            self.subtitle = "created_at: \(location.created_at!.formatDate())"
        }
        else if location.driver_id != nil && location.created_at != nil {
            self.title = String(format: "%i", location.driver_id!)
            self.subtitle = "created_at: \(location.created_at!.formatDate())"
        }
        else if location.created_at != nil{
            self.title = "N/A"
            self.subtitle = "created_at: \(location.created_at!.formatDate())"
        }

    }
    
}

extension String {
    
    func formatDate() -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"


        if let date: Date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        }

        return ""
        
    }
    
}
