//
//  Contact.swift
//  HWContactBook
//
//  Created by Alisher on 9/23/19.
//  Copyright © 2019 Alisher. All rights reserved.
//

import Foundation
import UIKit

class Contact {
    private var contact_image : UIImage?
    private var contact_name_surname : String?
    private var contact_tel : String?
    init(_ contact_image: UIImage, _ contact_name_surname : String, _ contact_tel : String) {
        self.contact_image = contact_image
        self.contact_tel = contact_tel
        self.contact_name_surname = contact_name_surname
    }
    var Contact_image: UIImage? {
        get {
            return contact_image
        }
    }
    
    var Contact_name_surname: String? {
        get {
            return contact_name_surname
        }
    }
    
    var Contact_tel: String? {
        get {
            return contact_tel
        }
    }
}
