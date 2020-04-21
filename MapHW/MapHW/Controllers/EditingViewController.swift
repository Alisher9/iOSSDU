//
//  EditingViewController.swift
//  MapHW
//
//  Created by Alisher Sattarbek on 11/3/19.
//  Copyright © 2019 AlisherSattarbek. All rights reserved.
//

import UIKit
import Cartography
import MapKit

class EditingViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.layer.cornerRadius = 0.9
        return titleLabel
    }()
    
    lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel(frame: .zero)
        subtitleLabel.layer.cornerRadius = 0.9
        return subtitleLabel
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
    }

    func setupNavigationBar() {
        
        let back = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = back
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.rightBarButtonItem = done
    }
    
    @objc func backButtonPressed() {
        func setRegion(_ region: MKCoordinateRegion, animated: Bool){
            
        }
    }
    
    @objc func doneButtonPressed() {
        
    }
    
    
    
}
