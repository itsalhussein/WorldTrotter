//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Hussein Anwar on 09/04/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    //MARK: - Properties
    var userLocation: CLLocationManager!
    var mapView: MKMapView!
    
    override func loadView() {
        //create a map view
        mapView = MKMapView()
        
        //Set it as *the* vuew if this view controller
        view = mapView
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let sataliteString = NSLocalizedString("Satalite", comment: "Satalite map view")
        
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, sataliteString])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self,
                                   action: #selector(mapTypeChanged(_:)),
                                   for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        //constraints of the segment *programmatically*
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        userLocation = CLLocationManager()
        userLocation.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        print("MapViewController loaded its view.")
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        let span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        let theRegion = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        mapView.setRegion(theRegion, animated: true)
    }
    
}
