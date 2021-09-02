//
//  TextField.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/27.
//

import UIKit

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
    
    func addHorizontalPadding(_ padding: CGFloat = 16) {
        let paddingView = UIView()
        paddingView.setDimensions(width: padding, height: 0)
        leftView = paddingView
        rightView = paddingView
        leftViewMode = .always
        rightViewMode = .always
    }
    
    func addLeftPadding(_ paddingLeft: CGFloat = 16) {
        let paddingView = UIView()
        paddingView.setDimensions(width: paddingLeft, height: 0)
        leftView = paddingView
        leftViewMode = .always
    }
    
}
