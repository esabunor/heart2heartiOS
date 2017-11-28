//
//  UIColorExtension.swift
//  heart2heart
//
//  Created by Tega Esabunor on 24/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    class var deep_purple_l5 : UIColor {
        return UIColor(rgb: 0xede7f6)
    }
    
    class var deep_purple_l3 : UIColor {
        return UIColor(rgb: 0xb39ddb)
    }
    
    class var teal_d3 : UIColor {
        return UIColor(rgb: 0x00695c)
    }
    
    class var cyan_d3 : UIColor {
        return UIColor(rgb: 0x00838f)
    }
    
    class var orange_l3 : UIColor {
        return UIColor(rgb: 0xffcc80)
    }
    
    class var amber : UIColor {
        return UIColor(rgb: 0xffc107)
    }
    
    class var lime : UIColor {
        return UIColor(rgb: 0xcddc39)
    }
    
    class var cyan_a4 : UIColor {
        return UIColor(rgb: 0x00b8d4)
    }
    
    class var light_blue_l1 : UIColor {
        return UIColor(rgb: 0x29b6f6)
    }
}
