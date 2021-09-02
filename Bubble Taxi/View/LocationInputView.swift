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
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureBackButton()
    }
    
    private func configureView() {
        backgroundColor = .white
        addShadow()
    }
    
    private func configureBackButton() {
        addSubview(backButton)
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, paddingTop: 12, paddingLeft: 24, width: 24, height: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors
    
    @objc func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
    
}
