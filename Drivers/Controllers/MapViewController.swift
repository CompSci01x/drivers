//
//  MapViewController.swift
//  Drivers
//
//  Created by Spruce Tree on 11/14/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    private var nearbyLocations: [NearbyLocation] = []
    
    func setNearbyLocations(nearbyLocations: [NearbyLocation]) {
        self.nearbyLocations = nearbyLocations
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func populateMapView() {
        
        if nearbyLocations.count > 0 {
            var annotationsArr: [MapPlotPoint] = []
            for nearbyLocation in nearbyLocations {
                annotationsArr.append(MapPlotPoint(location: nearbyLocation.location!))
            }

            mapView.addAnnotations(annotationsArr)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MapPlotPoint else {
            return nil
        }
        
        let identifier = "MapPlotPoint"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        return annotationView
    }
    
}
