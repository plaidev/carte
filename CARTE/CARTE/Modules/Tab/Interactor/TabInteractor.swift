//
//  TabTabInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 03/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseAuth
import FirebaseAnalytics
import KarteTracker

class TabInteractor: NSObject, TabInteractorInput {
    private let locationManager = CLLocationManager()

    weak var output: TabInteractorOutput!

    func trackLocation() {
        requestLocationPermission()
    }
    
    private func requestLocationPermission() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }
}

extension TabInteractor: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard case .authorizedWhenInUse = status else {
            return
        }
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else {
            return
        }
        
        KarteTracker.shared.identify([
            "latlng": [coordinate.longitude, coordinate.latitude]
        ])
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
