//
//  Configs.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation
import UIKit

//MARK: - Admob
struct GoogleAds {
    static let interstitialAdUnitID = "ca-app-pub-3940256099942544/4411468910_"
    static let bannerAdUnitID = "ca-app-pub-3940256099942544/2934735716"
    static let openAdUnitID = "ca-app-pub-3940256099942544/5662855259"
}

struct AppConfigs {
    static let rateAppURL = "https://apps.apple.com/app/id1557161547"

}


struct NotificationUser {
    static let timeInterval: TimeInterval = Double.random(in: 43200...86400)  //  (12 tieng)
    static var body: String = "A funny rhythm game where you battle it with your hot girlfriend’s dad. Friday Night Funkin' is a cool music rhythm game"
}

