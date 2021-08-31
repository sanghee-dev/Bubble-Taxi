//
//  HomeController.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/29.
//

import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {
    
    // MARK: Properties
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    private let inputActivationView = LocationInputActivationView()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        enableLocationServices()
    }
    
    // MARK: API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                //nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureUI()
        }
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Helper Functions
    
    private func configureUI() {
        configureNavigationBar()
        configureMapView()
        configureInputActivationView()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    private func configureInputActivationView() {
        view.addSubview(inputActivationView)
        inputActivationView.centerX(inView: view)
        inputActivationView.setDimensions(width: view.frame.width - 64, height: 48)
        inputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    }

}

// MARK: LocationServices

extension HomeController: CLLocationManagerDelegate {
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch locationManager.authorizationStatus {
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse: locationManager.requestAlwaysAuthorization()
        case .notDetermined: locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied: break
        @unknown default: break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}
