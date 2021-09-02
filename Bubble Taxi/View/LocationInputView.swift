//
//  LocationInputView.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/09/02.
//

import UIKit

protocol LocationInputViewDelegate: AnyObject {
    func dismissLocationInputView()
}

class LocationInputView: UIView {

    // MARK: Properties
    
    weak var delegate: LocationInputViewDelegate?
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Where to?"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()
    
    private let startLocationIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let indicatorlinkingView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let destinationIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var startingLocationTextField: UITextField = {
        let textField = UITextField()
        textField.addHorizontalPadding()
        textField.placeholder = "Current location"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.cornerRadius = 18
        textField.backgroundColor = .systemGroupedBackground
        textField.isEnabled = false
        return textField
    }()
    
    private lazy var destinationLocationTextField: UITextField = {
        let textField = UITextField()
        textField.addHorizontalPadding()
        textField.placeholder = "Enter a destination"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.cornerRadius = 18
        textField.backgroundColor = .systemGray5
        textField.isEnabled = false
        textField.returnKeyType = .search
        return textField
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    private func configureUI() {
        configureView()
        configureBackButton()
        configureTitleLabel()
        configureTextFields()
        configureIndicatorViews()
    }
    
    private func configureView() {
        backgroundColor = .white
        addShadow()
    }
    
    private func configureBackButton() {
        addSubview(backButton)
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, paddingTop: 12, paddingLeft: 16, width: 24, height: 24)
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
        titleLabel.centerY(inView: backButton)
    }
    
    private func configureTextFields() {
        addSubview(startingLocationTextField)
        startingLocationTextField.anchor(top: backButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 48, paddingRight: 24, height: 36)
        
        addSubview(destinationLocationTextField)
        destinationLocationTextField.anchor(top: startingLocationTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 48, paddingRight: 24, height: 36)
    }
    
    private func configureIndicatorViews() {
        addSubview(startLocationIndicatorView)
        startLocationIndicatorView.centerY(inView: startingLocationTextField)
        startLocationIndicatorView.setDimensions(width: 6, height: 6)
        startLocationIndicatorView.anchor(left: leftAnchor, paddingLeft: 24)
  
        addSubview(destinationIndicatorView)
        destinationIndicatorView.centerY(inView: destinationLocationTextField)
        destinationIndicatorView.setDimensions(width: 6, height: 6)
        destinationIndicatorView.anchor(left: leftAnchor, paddingLeft: 24)
        
        addSubview(indicatorlinkingView)
        indicatorlinkingView.centerX(inView: startLocationIndicatorView)
        indicatorlinkingView.anchor(top: startLocationIndicatorView.bottomAnchor, bottom: destinationIndicatorView.topAnchor, paddingTop: 8, paddingBottom: 8, width: 0.5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors
    
    @objc func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
    
}
