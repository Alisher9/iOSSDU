//
//  SecondViewController.swift
//  Animation
//
//  Created by Alisher Sattarbek on 11/18/19.
//  Copyright © 2019 AlisherSattarbek. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class SecondViewController: UIViewController {
    
    lazy var tableView = UITableView()
    var count = 0.0
    
    var phones:[Phones] = [
        Phones("Iphone 7 Plus" , "350$", "A10 Fusion" , "12MPX"),
        Phones("Samsung Galaxy S8" , "500$", "Snapdragon 835" , "12MPX"),
        Phones("LG G4" , "400$", "Snapdragon 808" , "16MPX"),
        Phones("Nexus 6P" , "700$", "Snapdragon 810" , "12.3MPX"),
        Phones("HTC One M9" , "500$", "Snapdragon 810" , "20MPX"),
        Phones("Google Pixel " , "650$", "Snapdragon 821" , "12MPx")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        constrain(tableView, view) {t, v in
            t.top == v.top + 40
            t.left == v.left
            t.right == v.right
            t.bottom == v.bottom
        }
    }
    
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
        tableView.isScrollEnabled = false
        view.addSubview(tableView)
    }
    
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        
        cell.transform = CGAffineTransform(translationX: -tableView.bounds.size.width , y: 1)
        UIView.animate(withDuration: 0.7, delay: 0.05 + count, options: .beginFromCurrentState, animations: {
            cell.transform = CGAffineTransform(translationX: 50, y: 0);
        }, completion: nil)
        count += 0.1
        
        cell.nameLabel.text = phones[indexPath.row].name
        cell.priceLabel.text = phones[indexPath.row].price
        cell.cpuLabel.text = phones[indexPath.row].cpu
        cell.cameraLabel.text = phones[indexPath.row].camera
        
        return cell
    }
    
    
    
}
