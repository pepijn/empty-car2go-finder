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
    // Car2go API URL, ripped it from their website
    private let car2goAPIURL = "https://www.car2go.com/api/v2.1/vehicles?loc=amsterdam&oauth_consumer_key=car2gowebsite&format=json"

    @IBOutlet weak var map: MKMapView!

    var cars: [Car] = [] {
        didSet {
            print("\(cars.count) cars loaded")
            self.carAnnotations = cars.map({ (car) -> CarAnnotation in
                return CarAnnotation(car: car)
            })
        }
    }

    var carAnnotations: [CarAnnotation] = [] {
        didSet {
            dispatch_async(dispatch_get_main_queue()) {
                self.map.addAnnotations(self.carAnnotations)
                self.map.removeAnnotations(oldValue)

                print("\(self.map.annotations.count) annotations on the map")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let center = CLLocationCoordinate2D.init(latitude: 52.37, longitude: 4.99)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.22, longitudeDelta: 0.4)
        map.setRegion(MKCoordinateRegion.init(center: center, span: span), animated: false)

        NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("loadCarsFromAPI"), userInfo: nil, repeats: true)
        loadCarsFromAPI()
    }

    func loadCarsFromAPI() {
        let apiURL = NSURL.init(string: car2goAPIURL)
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.init(configuration: sessionConfiguration)
        let task = session.dataTaskWithURL(apiURL!) { (data, response, error) -> Void in
            let options = NSJSONReadingOptions.AllowFragments
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: options) as! NSDictionary
                let placemarks = json["placemarks"] as! NSArray

                self.cars = placemarks.map({ (data) -> Car in
                    return Car(data: data as! NSDictionary)
                })
            } catch {
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? CarAnnotation {
            let identifier = String(annotation.car.freeMinutesRewardLevel)
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.animatesDrop = !annotation.car.noFreeMinutesReward
                view.pinTintColor = annotation.pinColor
                view.alpha = annotation.alpha
                view.layer.zPosition = annotation.zPosition
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
                view.rightCalloutAccessoryView?.layer.zPosition = 1.0 // Max charge is 100
            }
            return view
        }
        return nil
    }
}
