//
//  LocationInputActivationView.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/31.
//

import UIKit

protocol ActivationInputViewDelegate: AnyObject {
    func presentLocationInputView()
}

class ActivationInputView: UIView {
    
    // MARK: Properties
    
    weak var delegate: ActivationInputViewDelegate?
    
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
        label.textColor = .black
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureTapGesture()
    }
    
    private func configureUI() {
        configureView()
        configureIndicatorView()
        configurePlaceholderLabel()
    }
    
    private func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 24
        addShadow()
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
    
    private func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentLocationInputView))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors
    @objc func presentLocationInputView() {
        delegate?.presentLocationInputView()
    }
}
