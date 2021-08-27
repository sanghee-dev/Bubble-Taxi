//
//  Color.swift
//  Bubble Taxi
//
//  Created by leeesangheee on 2021/08/27.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let backgroundColor = UIColor.rgb(red: 255, green: 255, blue: 255)
    static let mainBlueTint = UIColor.systemTeal
}
