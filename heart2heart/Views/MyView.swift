//
//  MyView.swift
//  heart2heart
//
//  Created by Tega Esabunor on 1/12/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit
import CoreGraphics
class MyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let con = UIGraphicsGetCurrentContext()!
        con.addEllipse(in: CGRect(x: 0, y: 0, width: 100, height: 100))
        con.setFillColor(UIColor.amber.cgColor)
        con.fillPath()
    }

}
