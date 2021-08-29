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
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        //signOut()
        checkIfUserIsLoggedIn()
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
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Helper Functions
    
    func configureUI() {
        configureNavigationBar()
        
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }

}
