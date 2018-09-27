//
//  CurrentLlocationViewController.swift
//  Refresher-SWIFT
//
//  Created by Abraham, Aneesh on 9/27/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!

    private var currentLocation: CLLocation? {
        didSet {
            guard let location = currentLocation else { return }
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            locationLabel.text =   "Location:\n Lat:\(latitude),\n Long:\(longitude)"
            print("\(latitude), \(longitude)")
        }
    }
    
    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        
        // Configure Location Manager
        locationManager.distanceFilter = 1000.0
        locationManager.desiredAccuracy = 1000.0
        
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        requestLocation()
        setupNotificationHandling()
    }
    
    private func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(CurrentLocationViewController.applicationDidBecomeActive(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        requestLocation()
    }
    
    private func requestLocation() {
        // Configure Location Manager
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // Request Current Location
            locationManager.requestLocation()
            
        } else {
            // Request Authorization
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: - Authorization
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // Request Location
            manager.requestLocation()
        }
    }
    
    // MARK: - Location Updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // Update Current Location
            currentLocation = location
            
            // Reset Delegate
            manager.delegate = nil
            
            // Stop Location Manager
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
        if currentLocation == nil {
            // Fall Back to Default Location
        }
    }
}
