//
//  LoginController.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/26.
//

import UIKit

class LoginController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Bubble"
        label.font = UIFont(name: "Futura", size: 36)
        label.textColor = .systemTeal
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                        constant: 40).isActive = true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
