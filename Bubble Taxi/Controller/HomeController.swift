//
//  HomeController.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/29.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    // MARK: Properties
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainBlueTint
        checkIfUserIsLoggedIn()
    }
    
    // MARK: API
    
    func checkIfUserIsLoggedIn() {
        if let currentUser = Auth.auth().currentUser {
            print(currentUser)
        } else {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }

}
