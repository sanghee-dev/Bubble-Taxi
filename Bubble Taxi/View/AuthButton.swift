//
//  AuthButton.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/27.
//

import UIKit

class AuthButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        backgroundColor = .mainBlueTint
        layer.cornerRadius = 24
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        let attributedTitle = NSAttributedString(
            string: title ?? "",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)])
        super.setAttributedTitle(attributedTitle, for: state)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
