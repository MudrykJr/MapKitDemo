//
//  ViewController.swift
//  MapKitDemo
//
//  Created by Vitalii Mudryk on 03.03.25.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager() //init location Manager user CoreLocation.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupProfileImage()
        setupLocationManager()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            setInitialMapLocation() //Set map to default location.
        }
    }
    
    func setupProfileImage() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2 //Make image circular.
        profileImageView.clipsToBounds = true
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() //Request the locationfrom the user.
        locationManager.startUpdatingLocation() //Starts the location tracking.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        let region = MKCoordinateRegion(
            center: userLocation.coordinate, latitudinalMeters: 5000,
            longitudinalMeters: 5000
        )
        mapView.setRegion(region, animated: true) //Center the map on the user.
    }
    
    func setInitialMapLocation() {
        let initialLocation = CLLocationCoordinate2D(latitude:     49.254606, longitude: -123.217643)
        let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
    }
}
