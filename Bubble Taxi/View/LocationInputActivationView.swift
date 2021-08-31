//
//  LocationInputActivationView.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/31.
//

import UIKit

class LocationInputActivationView: UIView {
    
    // MARK: Properties
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = .black
        return view
    }()
    
    private let placeholderLabel: UILabel = {
       let label = UILabel()
        label.text = "Where to?"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    private func configureUI() {
        configureView()
        configureIndicatorView()
        configurePlaceholderLabel()
    }
    
    private func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 24
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
    }
    
    private func configureIndicatorView() {
        addSubview(indicatorView)
        indicatorView.centerY(inView: self)
        indicatorView.anchor(left: leftAnchor, paddingLeft: 24)
        indicatorView.setDimensions(width: 6, height: 6)
    }
    
    private func configurePlaceholderLabel() {
        addSubview(placeholderLabel)
        placeholderLabel.centerY(inView: self)
        placeholderLabel.anchor(left: indicatorView.rightAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
