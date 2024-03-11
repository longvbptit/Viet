//
//  ApplicationManager.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation

class ApplicationManager: NSObject {
    static let shared: ApplicationManager = ApplicationManager()
    
    private let kLaunchAppNumber = "kNumberofLaunchApplication"
    var launchAppNumber: Int {
        get {
            return UserDefaults.standard.integer(forKey: kLaunchAppNumber)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kLaunchAppNumber)
            UserDefaults.standard.synchronize()
            print("new value numberofLaunchApplication: \(newValue)")
        }
    }
    
    private let kHasbeenLiked = "kHasbeenLiked"
    var hasbeenLiked: Bool {
        get {
            return UserDefaults.standard.bool(forKey: kHasbeenLiked)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kHasbeenLiked)
            UserDefaults.standard.synchronize()
            print("new value hasbeenLiked: \(newValue)")
        }
    }
    
    private let kHasBeenRate = "kHasBeenRate"
    var hasBeenRated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: kHasBeenRate)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: kHasBeenRate)
            UserDefaults.standard.synchronize()
            print("Has Been Rated: \(newValue)")
        }
    }
}
