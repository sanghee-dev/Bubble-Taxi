//
//  Extensions.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/26.
//

import UIKit

extension UIView {
    
    func textFieldContainerView(imageName: String, textField: UITextField) -> UIView {
        let view = UIView()
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = .systemTeal
    
        view.addSubview(imageView)
        imageView.centerY(inView: view)
        imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24)
        
        view.addSubview(textField)
        textField.centerY(inView: view)
        textField.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGroupedBackground
        view.addSubview(separatorView)
        separatorView.anchor(left: textField.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: 1)
        
        return view
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func centerY(inView view: UIView) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension UITextField {
    
    func textField(withPlaceholder placeholder: String, isSecureTextEntry: Bool) -> UITextField {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .black
        tf.keyboardAppearance = .light
        tf.isSecureTextEntry = isSecureTextEntry
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return tf
    }
    
}
