//
//  Label.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/27.
//

import UIKit

extension UILabel {
    
    func titleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Bubble"
        label.font = UIFont(name: "Futura", size: 72)
        label.textColor = .mainBlueTint
        return label
    }
    
}
