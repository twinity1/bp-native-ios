//
//  GPSViewController.swift
//  BP
//
//  Created by Aleš Kůtek on 04.02.2021.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class GPSViewController : UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let an = MKPointAnnotation()
        an.coordinate = locations.first!.coordinate
        
        mapView.addAnnotation(an)
    }
}
