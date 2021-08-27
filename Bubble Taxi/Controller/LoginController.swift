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
        label.font = UIFont(name: "Futura", size: 72)
        label.textColor = .systemTeal
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView()
        
        view.addSubview(emailIcon)
        emailIcon.centerY(inView: view)
        emailIcon.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24)
        
        view.addSubview(emailTextField)
        emailTextField.centerY(inView: view)
        emailTextField.anchor(left: emailIcon.rightAnchor,
                              bottom: view.bottomAnchor,
                              right: view.rightAnchor,
                              paddingLeft: 8,
                              paddingBottom: 8)

        view.addSubview(separatorView)
        separatorView.anchor(left: emailTextField.leftAnchor,
                             bottom: view.bottomAnchor,
                             right: view.rightAnchor,
                             height: 1)
                
        return view
    }()
    
    private let emailIcon: UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope")
        imageView.alpha = 1
        imageView.tintColor = .systemTeal
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .black
        tf.keyboardAppearance = .light
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return tf
    }()
    
    private let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGroupedBackground
        return separatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          paddingTop: 60,
                          paddingLeft: 32)
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: titleLabel.bottomAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  paddingTop: 40,
                                  paddingLeft: 32,
                                  paddingRight: 32,
                                  height: 50)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
}
