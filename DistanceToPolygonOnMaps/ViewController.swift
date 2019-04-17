//
//  ViewController.swift
//  DistanceToPolygonOnMaps
//
//  Created by VADIM FIRSOV on 17/04/2019.
//  Copyright © 2019 VADIM FIRSOV. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapViewOutlet: MKMapView!
    
    var annot = MKPointAnnotation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnMap))
        mapViewOutlet.addGestureRecognizer(tap)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("WTF")
        return MKAnnotationView()
    }
    
    @objc func tapOnMap(sender : UITapGestureRecognizer) {
        print("YOOHOO")
        let touchLocation = sender.location(in: mapViewOutlet)
        let locationCoordinate = mapViewOutlet.convert(touchLocation, toCoordinateFrom: mapViewOutlet)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        annot.coordinate = CLLocationCoordinate2D(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        mapViewOutlet.addAnnotation(annot)
    }

    @IBAction func btnPressed(_ sender: UIButton) { }
    
}

