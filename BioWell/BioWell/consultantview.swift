//
//  consultantview.swift
//  BioWell
//
//  Created by Ahsan Habib Swassow on 23/11/23.
//

import UIKit
import MapKit
import CoreLocation

class consultantview: UIViewController, CLLocationManagerDelegate {
    lazy var locationmanager : CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var locationset: UIButton!
    @IBOutlet weak var mapsviews: MKMapView!
    struct LocationInfo {
        let name: String
        let latitude: Double
        let longitude: Double
    }
    let locations = [
        LocationInfo(name: "Khulna Medical Collage", latitude: 22.828176, longitude: 89.536735),
        LocationInfo(name: "Bangladesh Navy Child and Woman Health Care Center", latitude: 22.85174487218643, longitude: 89.53018468328719),
        LocationInfo(name: "Khulna City Hospital", latitude: 22.846389844051707, longitude: 89.54025746266856),
        LocationInfo(name: "Digholia Upazila Health Complex", latitude: 22.875201181254944, longitude: 89.524973823523),
        LocationInfo(name: "Specialized Hospital", latitude: 22.825772302864735, longitude: 89.5398457980106)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Pop the current view controller off the navigation stack
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        let latitude = 23.6850
        let longitude = 90.3563
               let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000)
        mapsviews.setRegion(region, animated: true)

        // Add a pin to the map
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Bangladesh"
        mapsviews.addAnnotation(annotation)
        mapsviews.isScrollEnabled = true
        mapsviews.isZoomEnabled = true
        mapsviews.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .authorizedWhenInUse || status == .authorizedAlways){
            locationmanager.startUpdatingLocation()
        }
    }
    func updatelocationonmap(to location: CLLocation ,with title : String?){
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
        self.mapsviews.addAnnotation(point)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        self.mapsviews.setRegion(region, animated: true)
    }
    
    
    func showAllLocationsOnMap() {
        if let firstLocation = locations.first {
             let centerCoordinate = CLLocationCoordinate2D(latitude: firstLocation.latitude, longitude: firstLocation.longitude)
             let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
             mapsviews.setRegion(region, animated: true)
         }
        for location in locations {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)

            // Add a pin to the map
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = location.name
            mapsviews.addAnnotation(annotation)
        }

        // Set region to include all locations
        mapsviews.showAnnotations(mapsviews.annotations, animated: true)
    }
    
    
    @IBAction func srch(_ sender: Any) {
        guard let countryName = search.text, !countryName.isEmpty else {
            showAlert(message: "Please enter District Name.")
            return
        }

        showAllLocationsOnMap()
        
    }
    @IBAction func loc(_ sender: Any) {
        updatelocationonmap(to: locationmanager.location ?? CLLocation(), with: "Test Location")
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
