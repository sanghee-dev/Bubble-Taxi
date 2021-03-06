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
    private let sharedLocationManager = LocationHandler.shared.locationManager
    
    private let activationInputView = ActivationInputView()
    private let locationInputView = LocationInputView()
    private let tableView = UITableView()
     
    private var user: User? {
        // called as soon as it gets set
        didSet { locationInputView.user = user }
    }
    
    private final let locationInputViewHeight: CGFloat = 200
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        enableLocationServices()
        fetchData()
    }
    
    // MARK: API
    
    private func fetchData() {
        fetchUserData()
        fetchDrivers()
    }
    
    private func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.shared.fetchUserData(uid: uid) { user in
            self.user = user
        }
    }
    
    // location -> drivers -> add annotations
    private func fetchDrivers() {
        guard let location = sharedLocationManager?.location else { return }
        Service.shared.fetchDrivers(location: location) { driver in            
            guard let coordinate = driver.location?.coordinate else { return }
            let annotation = DriverAnnotation(uid: driver.uid, coordinate: coordinate)
            
            // Update driver annotation
            var driverIsVisible: Bool {
                return self.mapView.annotations.contains { annotation -> Bool in
                    guard let driverAnno = annotation as? DriverAnnotation else { return false }
                    if driverAnno.uid == driver.uid {
                        driverAnno.updateAnnotationPosition(withCoordinate: coordinate)
                        return true
                    }
                    return false
                }
            }
            
            if !driverIsVisible {
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    private func enableLocationServices() {
        LocationHandler.shared.enableLocationServices()
    }
    
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureUI()
        }
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Helper Functions
    
    func configureUI() {
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
        mapView.delegate = self
    }
    
    private func configureActivationInputView() {
        activationInputView.delegate = self
        
        view.addSubview(activationInputView)
        activationInputView.centerX(inView: view)
        activationInputView.setDimensions(width: view.frame.width - 64, height: 48)
        activationInputView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        activationInputView.alpha = 0

        UIView.animate(withDuration: 0.5) {
            self.activationInputView.alpha = 1
        }
    }
    
    private func configureLocationInputView() {
        locationInputView.delegate = self
        
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: locationInputViewHeight)
        locationInputView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.locationInputView.alpha = 1
            self.tableView.frame.origin.y = self.locationInputViewHeight
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView() // delete extra lines
        
        let height = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: height)
        
        tableView.backgroundColor = .systemGray6
        
        view.addSubview(tableView)
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
        UIView.animate(withDuration: 0.3) {
            self.locationInputView.alpha = 0
            self.tableView.frame.origin.y = self.view.frame.height
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.activationInputView.alpha = 1
                self.locationInputView.removeFromSuperview()
            }
        }
    }
}

// MAKR: MapView

extension HomeController: MKMapViewDelegate {
    
    // change annotation image
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DriverAnnotation {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: DRIVER_ANNOTATION)
            view.image = UIImage(systemName: "location.circle.fill")
            return view
        }
        return nil
    }
    
}

// MARK: Delegate

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Favorites" : " "
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let tableView = view as? UITableViewHeaderFooterView else { return }
        tableView.contentView.backgroundColor = .systemGray6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocationCell
        return cell
    }
}
