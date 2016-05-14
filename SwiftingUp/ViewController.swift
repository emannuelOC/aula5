//
//  ViewController.swift
//  SwiftingUp
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/14/16.
//  Copyright © 2016 OC. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    let initialLocation = CLLocation(latitude: -23, longitude: -46)
    
    override func viewDidLoad() {
        centerMapOnLocation(initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

