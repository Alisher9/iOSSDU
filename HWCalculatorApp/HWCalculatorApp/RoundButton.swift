//
//  RoundButton.swift
//  HWCalculatorApp
//
//  Created by Alisher on 9/15/19.
//  Copyright © 2018 Alisher. All rights reserved.
//

import UIKit

@IBDesignable
    class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height/2
    }
    
}

