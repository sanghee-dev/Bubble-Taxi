//
//  HomeController.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/29.
//

import UIKit
import Firebase
import MapKit

private let reuseIdentifier = "LocationCell"

class HomeController: UIViewController {
    
    // MARK: Properties
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    private let activationInputView = ActivationInputView()
    private let locationInputView = LocationInputView()
    private let tableView = UITableView()
    
    private final let locationInputViewHeight: CGFloat = 200
    
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
        configureActivationInputView()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    private func configureActivationInputView() {
        activationInputView.delegate = self
        
        view.addSubview(activationInputView)
        activationInputView.centerX(inView: view)
        activationInputView.setDimensions(width: view.frame.width - 64, height: 48)
        activationInputView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        activationInputView.alpha = 0

        UIView.animate(withDuration: 0.5, animations: {
            self.activationInputView.alpha = 1 })
    }
    
    private func configureLocationInputView() {
        locationInputView.delegate = self
        
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: locationInputViewHeight)
        locationInputView.alpha = 0
        
        UIView.animate(withDuration: 0.3,
                       animations: { self.locationInputView.alpha = 1 },
                       completion: { _ in print("configureLocationInputView") })
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        
        let height = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height - 100, width: view.frame.width, height: height)
        
        tableView.backgroundColor = .white
        
        view.addSubview(tableView)
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

// MARK: Delegate

extension HomeController: ActivationInputViewDelegate {
    func presentLocationInputView() {
        activationInputView.alpha = 0
        configureLocationInputView()
    }
}


extension HomeController: LocationInputViewDelegate {
    func dismissLocationInputView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.locationInputView.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.activationInputView.alpha = 1
            })
        })
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocationCell
        return cell
    }
}
