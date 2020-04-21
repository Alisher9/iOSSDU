//
//  MyTableViewController.swift
//  HWContactBook
//
//  Created by Alisher on 9/23/19.
//  Copyright © 2019 Alisher. All rights reserved.
//

import Foundation
import UIKit

class MyTableViewController: UITableViewController, Receiver, DeleteContact, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func deleteContact(_ index: Int) {
        contacts.remove(at: index)
        tableView.reloadData()
    }
   
    override func viewDidLoad() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
   
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No contacts"
        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Tap the button '+' to add your first contact"
        let attrs = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    

    var value: Contact? {
        didSet{
            contacts.append(value!)
            tableView.reloadData()
        }
    }
    var contacts : [Contact] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return contacts.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactBook", for: indexPath) as! CustomCell
        
        cell.contact_imageView.image = contacts[indexPath.row].Contact_image
        cell.contact_name_label.text = contacts[indexPath.row].Contact_name_surname
        cell.contact_tel_label.text = contacts[indexPath.row].Contact_tel
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func save(a contact: Contact) {
        contacts.append(contact)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "second" {
            let destination = segue.destination as! SecondViewController
            destination.second_name_text = contacts[(tableView.indexPathForSelectedRow?.row)!].Contact_name_surname!
            destination.second_tel_text = contacts[(tableView.indexPathForSelectedRow?.row)!].Contact_tel!
            destination.second_image = contacts[(tableView.indexPathForSelectedRow?.row)!].Contact_image!
            destination.currentIndex = tableView.indexPathForSelectedRow?.row
            destination.deleteContact = self
        } else {
            let destination = segue.destination as! AddingContactController
            destination.receiver = self
        }
    }
}

