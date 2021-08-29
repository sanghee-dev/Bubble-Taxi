//
//  SignUpController.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/27.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    // MARK: Properties
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(imageName: "envelope", textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let view = UIView().inputContainerView(imageName: "person", textField: usernameTextField)
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(imageName: "lock", textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return view
    }()
    
    private lazy var accountTypeContainerView: UIView = {
        let view = UIView()
        view.addSubview(accountTypeSegmentedControl)
        accountTypeSegmentedControl.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 8, paddingRight: 8)
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return view
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    
    private let usernameTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Username", isSecureTextEntry: false)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private let accountTypeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Rider", "Driver"])
        sc.backgroundColor = .backgroundColor
        sc.tintColor = UIColor(white: 1, alpha: 0.87)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private let signUpButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        let signUpTitle = NSMutableAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint])
        attributedTitle.append(signUpTitle)
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contigureUI()
    }
    
    // MARK: Selectors]]
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        let accountTypeIndex = accountTypeSegmentedControl.selectedSegmentIndex
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error)
                return
            }
            guard let uid = result?.user.uid else { return }
            
            let values: [String: Any] = ["email": email, "username": username, "accountType": accountTypeIndex]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values) { error, ref in
                print("계정생성 성공")
            }
        }
    }
    
    @objc func handleShowSignUp() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Helper Functions
    
    func contigureUI() {
        configureNavigationBar()
        view.backgroundColor = .backgroundColor
        
        let title = UILabel().titleLabel()
        view.addSubview(title)
        title.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 60, paddingLeft: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, usernameContainerView, passwordContainerView, accountTypeContainerView, signUpButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: title.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 80, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
    
}
