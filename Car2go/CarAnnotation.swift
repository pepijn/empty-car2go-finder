//
//  CarAnnotation.swift
//  Car2go
//
//  Created by Pepijn Looije on 24/10/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    let car: Car

    var title: String? {
        return "\(car.numberPlate) (charge: \(car.charge)%)"
    }

    var subtitle: String? {
        return "\(car.address)"
    }

    var pinColor: UIColor {
        if car.freeMinutesReward       { return UIColor.greenColor() }
        if car.almostFreeMinutesReward { return UIColor.yellowColor() }
        return UIColor.blueColor()
    }

    var alpha: CGFloat {
        if car.noFreeMinutesReward { return 0.25 }
        return 1
    }

    var zPosition: CGFloat {
        return -CGFloat(car.charge)
    }

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: car.latitude, longitude: car.longitude)
    }

    init(car: Car) {
        self.car = car
        super.init()
    }
}
