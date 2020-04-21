//
//  SecondViewController.swift
//  HWContactBook
//
//  Created by Alisher on 9/23/19.
//  Copyright © 2019 Alisher. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate {
    var second_name_text = String()
    var second_tel_text = String()
    var second_image = UIImage()
    var currentIndex: Int?
    var deleteContact: DeleteContact?
    
    @IBOutlet weak var second_imageView: UIImageView!
    
    @IBOutlet weak var second_name_label: UILabel!
    
    @IBOutlet weak var second_tel_label: UILabel!
    
    
    @IBAction func call_button(_ sender: UIButton) {
        
        if let url = URL(string: "tel://\(second_tel_text)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }

    }
    
    
    @IBAction func delete_button(_ sender: UIButton) {
        deleteContact?.deleteContact(currentIndex!)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        second_name_label.text = second_name_text
        second_tel_label.text = second_tel_text
        second_imageView.image = second_image
    }
}
