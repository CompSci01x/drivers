//
//  ViewController.swift
//  Drivers
//
//  Created by Spruce Tree on 11/14/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var nearbyLocations: [NearbyLocation] = []
    private var mapVC: MapViewController = MapViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = UIColor(red: 202/255, green: 252/255, blue: 255/255, alpha: 1)
        
        
        let callApiButton = UIButton()
        callApiButton.setTitle("Call API", for: .normal)
        callApiButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        callApiButton.backgroundColor = UIColor(red: 0/255, green: 242/255, blue: 255/255, alpha: 1)
        callApiButton.layer.cornerRadius = 10
                
        callApiButton.addTarget(self, action: #selector(callApiButtonClicked), for: .touchUpInside)
        view.addSubview(callApiButton)
        
        callApiButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            callApiButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            callApiButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            
            callApiButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            callApiButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    

    @objc func callApiButtonClicked() {
        callApi()
        mapVC.populateMapView()
    }
    
    private func callApi() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "airspace-carmen-mock.herokuapp.com"
        urlComponents.path = "/v1/locations/nearby"
        urlComponents.queryItems = [
            URLQueryItem(name: "latitude", value: "37.33232211"),
            URLQueryItem(name: "longitude", value: "-122.05719234"),
            URLQueryItem(name: "radius", value: "100"),
            URLQueryItem(name: "radius_unit", value: "mi")
        ]
    
        let url = URL(string: urlComponents.string!)!
        var request = URLRequest(url: url)
        
        let headers = ["Authorization": "acc8208199df5ceb424428fc28de8a9d739dd4a080cc4fd72812b6601dc2d22866cc402e62741a4cee7eb90768f641a3c47c919894438c063678d4e0cb2342b8"]
        
        request.allHTTPHeaderFields = headers
        
        let sem = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            defer {sem.signal()}
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error: \(error!)")
                return
            }

//            print("JSON String: \(String(data: data!, encoding: .utf8) ?? "")")

            let result = try! JSONDecoder().decode(AirspaceApi.self, from: data!)
            self.nearbyLocations = result.nearbyLocations ?? []
            self.mapVC.setNearbyLocations(nearbyLocations: self.nearbyLocations)
        }
        task.resume()
        sem.wait()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMapKitVC" {
            if let destVC = segue.destination as? MapViewController {
                mapVC = destVC
            }
        }
        
        if segue.identifier == "ToAllLocationsTableVC" {
            if let destVC = segue.destination as? UINavigationController {
                if let theDest = destVC.topViewController as? AllLocationsTableViewController {
                    theDest.updateNearbyLocationsData(nearbyLocations: self.nearbyLocations)
                }
            }
        }
        
    }
    
}

