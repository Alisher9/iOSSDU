//
//  MapViewController.swift
//  MapHW
//
//  Created by Alisher Sattarbek on 11/3/19.
//  Copyright © 2019 AlisherSattarbek. All rights reserved.
//
import UIKit
import MapKit
import Cartography
import CoreData

class MapViewController: UIViewController {
    var mesta: [Place] = []
    private var styles : [Int: MKMapType] = [
        0: MKMapType.standard,
        1: MKMapType.satellite,
        2: MKMapType.hybrid]
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = self
        let tapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(tappedToMap))
        mapView.addGestureRecognizer(tapGestureRecognizer)
        return mapView
    }()
    
    lazy var tableView = UITableView()
    
    lazy var bottomView: UIView = {
        let bottomView = UIView(frame: .zero)
        bottomView.backgroundColor = .white
        bottomView.alpha = 0.8
        //bottomView.addSubview(forwardButton)
       // bottomView.addSubview(backwardButton)
        return bottomView
    }()
    
    lazy var listView: UIView = {
        let listView = UIView(frame: .zero)
        listView.backgroundColor = .white
        listView.alpha = 0.8
        listView.isHidden = true
        return listView
    }()
    
//    lazy var backwardButton: UIButton = {
//        let backwardButton = UIButton(frame: .zero)
//        backwardButton.addTarget(self, action: #selector(backwardButtonPressed), for: .touchUpInside)
//        return backwardButton
//    }()
//
//    @objc func backwardButtonPressed() {
//        mapView.setRegion(<#T##region: MKCoordinateRegion##MKCoordinateRegion#>, animated: <#T##Bool#>)
//    }
//
//    lazy var forwardButton: UIButton = {
//        let forwardButton = UIButton(frame: .zero)
//        forwardButton.addTarget(self, action: #selector(forwardButtonPressed), for: .touchUpInside)
//        return forwardButton
//
//    }()
//
//    @objc func forwardButtonPressed() {
//        print("forward pressed")
//    }
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Standard", "Satellite", "Hybrid"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.tintColor = .blue
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlPressed), for: .valueChanged)
        return segmentedControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        view.addSubview(bottomView)
        view.addSubview(segmentedControl)
        view.addSubview(listView)
        setupTableView()
        setupConstaints()
        setupOriginLocation()
        setupNavigationBar()
        mesta = loadData()
        
        for m in mesta {
            let annotation: MKPointAnnotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: m.latitude, longitude: m.longitude)
            annotation.title = m.title
            annotation.subtitle = m.subtitle
            self.mapView.addAnnotation(annotation)
        }
    }
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        listView.addSubview(tableView)
    }
    @objc func tappedToMap(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        let alert = UIAlertController(title: "Add Place", message: "Fill all the fields", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter title"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter subtitle"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let title = alert?.textFields![0].text
            let subtitle = alert?.textFields![1].text
            self.saveData(title, subtitle, coordinate.latitude, coordinate.longitude)
            
            let annotation: MKPointAnnotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = title
            annotation.subtitle = subtitle
            self.mapView.addAnnotation(annotation)
            self.mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
            self.navigationItem.title = title
          
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    @objc func segmentedControlPressed(sender: UISegmentedControl) {
        mapView.mapType = styles[sender.selectedSegmentIndex]!
    }
    func setupOriginLocation() {
        let originLocation = CLLocationCoordinate2D(latitude: 43.207664803003425, longitude: 76.6697376098981)
        mapView.setRegion(MKCoordinateRegion(center: originLocation, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
    }
    
    
    func setupNavigationBar() {
        navigationController?.navigationBar.alpha = 0.9
        let listLocation = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.organize, target: self, action: #selector(listLocationItemPressed))
        navigationItem.rightBarButtonItem = listLocation
        
        
    }
    @objc func listLocationItemPressed() {
        if(listView.isHidden) {
            listView.isHidden = false
        } else {
            listView.isHidden = true
        }
        tableView.reloadData()
    }
    func setupConstaints() {
        constrain(mapView, bottomView, segmentedControl, listView, view) { mv, bottomView, segmentedControl, listView, view in
            mv.top == view.top
            mv.left == view.left
            mv.right == view.right
            mv.bottom == view.bottom
            
            bottomView.bottom == view.bottom
            bottomView.left == view.left
            bottomView.right == view.right
            bottomView.height == 80 / 736 * UIScreen.main.bounds.height
            
            segmentedControl.top == bottomView.top + (25 / 736 * UIScreen.main.bounds.height)
            segmentedControl.left == bottomView.left + (82 / 414 * UIScreen.main.bounds.width)
            segmentedControl.height == 30 / 736 * UIScreen.main.bounds.height
            segmentedControl.width == 250 / 414 * UIScreen.main.bounds.width
            
            listView.top == view.top
            listView.width == UIScreen.main.bounds.width
            listView.bottom == bottomView.top
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func saveData(_ title: String?, _ subtitle: String?, _ latitude: Double?, _ longitude: Double?) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            if let entity = NSEntityDescription.entity(forEntityName: "Place", in: context) {
                let place = NSManagedObject(entity: entity, insertInto: context)
                place.setValue(title, forKey: "title")
                place.setValue(subtitle, forKey: "subtitle")
                place.setValue(latitude, forKey: "latitude")
                place.setValue(longitude, forKey: "longitude")
                
                do {
                    try context.save()
                       mesta.append(place as! Place)
                } catch {
                    print("Error")
                }
            }
        }
        
    }
    func loadData()-> [Place] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
              let fetchRequest = NSFetchRequest<Place>(entityName: "Place")
            do {
                try mesta = context.fetch(fetchRequest)
            } catch {
                print("Hello error")
            }
    }
     return mesta
}
    func deletePlace(_ object: Place) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            context.delete(object)
            do {
                try context.save()
            }
            catch {
                print("hello error")
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mesta.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30.0)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20.0)
      
        cell.textLabel?.text = mesta[indexPath.row].title
        cell.detailTextLabel?.text = mesta[indexPath.row].subtitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let current_places_location = mesta[indexPath.row]
        print(current_places_location)
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: current_places_location.latitude, longitude: current_places_location.longitude), latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
        navigationItem.title = mesta[indexPath.row].title
        self.listView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletePlace(mesta[indexPath.row])
            tableView.reloadData()
        }
    }
}
