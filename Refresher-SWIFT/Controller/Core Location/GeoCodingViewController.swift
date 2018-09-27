//
//  GeoCodingViewController.swift
//  Refresher-SWIFT
//
//  Created by Abraham, Aneesh on 9/27/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit
import CoreLocation

class GeoCodingViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var placeLabel: UILabel!
    private var locations: [Location] = []
    private lazy var geocoder = CLGeocoder()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Show Keyboard
        searchBar.becomeFirstResponder()
    }
    
    private func geocode(addressString: String?) {
        guard let addressString = addressString else {
            return
        }
        // Geocode City
        geocoder.geocodeAddressString(addressString) { [weak self] (placemarks, error) in
            DispatchQueue.main.async {
                // Process Forward Geocoding Response
                self?.processResponse(withPlacemarks: placemarks, error: error)
            }
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
        } else if let matches = placemarks {
            // Update Locations
            locations = matches.compactMap({ (match) -> Location? in
                guard let name = match.name else { return nil }
                guard let location = match.location else { return nil }
                return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            })
            
            if let firstLocation = locations.first {
                placeLabel.text = "Place:\(firstLocation.name), Lat:\(firstLocation.latitude), Long:\(firstLocation.longitude)"
            }
        }
    }

}

extension GeoCodingViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()
        // Forward Geocode Address String
        geocode(addressString: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()
        placeLabel.text = ""
    }
    
}

struct Location {
    // MARK: - Properties
    let name: String
    let latitude: Double
    let longitude: Double
}
