//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Hussein Anwar on 09/04/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    //MARK: - Properties
    
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapVC loaded its view.")
    }
    
}
