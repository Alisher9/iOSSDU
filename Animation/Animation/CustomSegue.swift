//
//  CustomSegue.swift
//  Animation
//
//  Created by Alisher Sattarbek on 11/18/19.
//  Copyright © 2019 AlisherSattarbek. All rights reserved.
//

import Foundation
import UIKit

class CustomSegue: UIStoryboardSegue {
    override func perform() {
        animate()
    }
    func animate(){
        
        
        let fromVC = self.source
        let toVC = self.destination
        let fromVCview = fromVC.view
        let toVCview = toVC.view
        toVCview?.alpha = 0
        toVCview?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        let container = fromVCview?.superview
        toVCview?.center = (fromVCview?.center)!
        container?.addSubview(toVCview!)
        UIView.animate(withDuration: 1, animations: {
            toVCview?.alpha = 1.0
            toVCview?.transform = CGAffineTransform.identity
        }) { (success) in
            fromVC.present(toVC, animated: false, completion: nil)
        }
        
    }
    
}
