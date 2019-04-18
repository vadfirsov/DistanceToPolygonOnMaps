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

    let kmlFileName = "Allowed area"
    let kmlFileType = "kml"

    var polygonView : MKPolygonRenderer!
    var polygonCoordinatePoints : [CLLocationCoordinate2D] = []

    @IBOutlet weak var mapViewOutlet: MKMapView!
    var kmlParseMngr : KMLParser!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnMap))
        mapViewOutlet.addGestureRecognizer(tap)
        mapViewOutlet.delegate = self
        parseKmlToMap()
    }
    
    func parseKmlToMap() {
        
        let path = Bundle.main.path(forResource: kmlFileName, ofType: kmlFileType)
        let url = URL(fileURLWithPath: path!)
        
        kmlParseMngr = KMLParser(url: url)
        kmlParseMngr.parseKML()
        
        let overlays : [MKOverlay] = kmlParseMngr.overlays as! [MKOverlay]
        let overlay = overlays[0]
        mapViewOutlet.addOverlay(overlay)
    
        print(overlay)
        var flyTo : MKMapRect = MKMapRect.null
        flyTo = overlay.boundingMapRect
        print(flyTo)
        
        mapViewOutlet.visibleMapRect = flyTo
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer { //called before

        polygonView = MKPolygonRenderer(overlay: overlay)
        polygonView.fillColor = #colorLiteral(red: 0.6223537922, green: 0.616006434, blue: 1, alpha: 0.3067476455)
        polygonView.strokeColor = #colorLiteral(red: 0.6762213707, green: 0.7094185948, blue: 1, alpha: 1)
        polygonView.lineWidth = 2
        let polyPoints = polygonView.polygon.points() //returns [MKMapPoint]
        
        for i in 0..<polygonView.polygon.pointCount {
            polygonCoordinatePoints.append(polyPoints[i].coordinate)
            print( "\(polyPoints[i].coordinate.latitude), \(polyPoints[i].coordinate.longitude)")
        }
     
 
        return polygonView

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return kmlParseMngr.view(for: annotation)
    }
    
    var annot = MKPointAnnotation()
    @objc func tapOnMap(sender : UITapGestureRecognizer) {
        let touchLocation = sender.location(in: mapViewOutlet)
        let locationCoordinate = mapViewOutlet.convert(touchLocation, toCoordinateFrom: mapViewOutlet)
        annot.coordinate = CLLocationCoordinate2D(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        mapViewOutlet.addAnnotation(annot)
        print("\(annot.coordinate.latitude), \(annot.coordinate.longitude)" )
    }

    @IBAction func btnPressed(_ sender: UIButton) { }
}

