//
//  ViewController.swift
//  Car2go
//
//  Created by Pepijn Looije on 22/10/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let center = CLLocationCoordinate2D.init(latitude: 52.37, longitude: 4.99)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.22, longitudeDelta: 0.4)
        map.setRegion(MKCoordinateRegion.init(center: center, span: span), animated: true)

        let annotation = MKPointAnnotation()

        map.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(mapView.region)
    }


}
