//
//  Car.swift
//  Car2go
//
//  Created by Pepijn Looije on 24/10/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

enum FreeMinutesRewardLevel {
    case Reward
    case AlmostReward
    case NoReward
}

class Car: NSObject {
    // https://www.car2go.com/en/amsterdam/how-does-car2go-work/
    private let freeMinutesThreshold = 30

    let address: String
    let numberPlate: String
    let charge: Int
    let latitude: Double
    let longitude: Double

    var freeMinutesRewardLevel: FreeMinutesRewardLevel {
        if (charge < freeMinutesThreshold)     { return FreeMinutesRewardLevel.Reward }
        if (charge < freeMinutesThreshold + 5) { return FreeMinutesRewardLevel.AlmostReward }
        return FreeMinutesRewardLevel.NoReward
    }

    var freeMinutesReward: Bool {
        return freeMinutesRewardLevel == FreeMinutesRewardLevel.Reward
    }

    var almostFreeMinutesReward: Bool {
        return freeMinutesRewardLevel == FreeMinutesRewardLevel.AlmostReward
    }

    var noFreeMinutesReward: Bool {
        return freeMinutesRewardLevel == FreeMinutesRewardLevel.NoReward
    }

    init(data: NSDictionary) {
        self.address = data["address"] as! String
        self.charge = data["fuel"] as! Int
        self.numberPlate = data["name"] as! String

        let coordinates = data["coordinates"] as! NSArray
        self.latitude = coordinates[1] as! Double
        self.longitude = coordinates[0] as! Double

        super.init()
    }
}
