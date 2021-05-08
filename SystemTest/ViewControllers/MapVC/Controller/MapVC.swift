//
//  MapVC.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var locArr = [LocationModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "MapView"
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        self.mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate {
            mapView.setCenter(coor, animated: true)
        }
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
   @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
  
    }

}
extension MapVC: MKMapViewDelegate, CLLocationManagerDelegate {
   
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("tapped on pin ")
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors " + error.localizedDescription)
    }
    
}

