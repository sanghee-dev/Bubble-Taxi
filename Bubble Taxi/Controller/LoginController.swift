//
//  LoginController.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/26.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginController: UIViewController {
    
    // MARK: Properties
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(imageName: "envelope", textField: emailTextField)
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(imageName: "lock", textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return view
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private let loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
//    private let googleLoginButton: GIDSignInButton = {
//        let button = GIDSignInButton()
//        button.colorScheme = .light
//        button.style = .iconOnly
//        button.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
//        return button
//    }()
    
    private let googleLoginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.setTitle("Log In with Google", for: .normal)
        button.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        let signUpTitle = NSMutableAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint])
        attributedTitle.append(signUpTitle)
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Selectors
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleGoogleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print(error)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleShowSignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: Helper Functions
    
    func configureUI() {
        configureNavigationBar()
        view.backgroundColor = .backgroundColor
        
        let title = UILabel().titleLabel()
        view.addSubview(title)
        title.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 60, paddingLeft: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton, googleLoginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: title.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 80, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
    }
}
