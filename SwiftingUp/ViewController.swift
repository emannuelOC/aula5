//
//  ViewController.swift
//  SwiftingUp
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 5/14/16.
//  Copyright © 2016 OC. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    
    let initialLocation = CLLocation(latitude: -23, longitude: -46)
    
    let locationManager = CLLocationManager()
    
    var annotations     = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        configureMapView()
        configureLocationManager()
    }
    
    func configureMapView() {
        centerMapOnLocation(initialLocation)
        mapView.showsUserLocation = true
        addLongPressGestureToView(mapView, withSelector: #selector(ViewController.didCaptureLongPress(_:)))
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func configureLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    // MARK: - LocationManager delegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(region, animated: true)
    }

    // MARK: - Gesture recognizers
    
    func addLongPressGestureToView(view: UIView, withSelector selector: Selector) {
        let gesture = UILongPressGestureRecognizer(target: self, action: selector)
        gesture.minimumPressDuration = 0.5
        view.addGestureRecognizer(gesture)
    }
    
    func didCaptureLongPress(gesture: UIGestureRecognizer) {
        let point = gesture.locationInView(mapView)
        let coordinate = mapView.convertPoint(point, toCoordinateFromView: mapView)
        addAnnotationToCoordinate(coordinate)
    }
    
    func addAnnotationToCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Annotation \(annotations.count + 1)"
        annotation.subtitle = "Só mais uma anotação legal! 🤓"
        mapView.addAnnotation(annotation)
    }
    
    var selectedAnnotation: MKAnnotation?
    
    @IBAction func removeSelectedAnnotation(sender: UIBarButtonItem) {
        removeAnnotations()
    }
    
    func removeAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
    }

}

