//
//  AppDelegate.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import GoogleMobileAds
import UserNotifications
import AppTrackingTransparency
import AdSupport


@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        window?.makeKeyAndVisible()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                print(status)
                GGAdmob.shared.loadInterstitial()
            })
        } else {
            GGAdmob.shared.loadInterstitial()
        }
        
        
        //Noti:
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ (allowed, error) in
            UNUserNotificationCenter.current().delegate = self
            self.scheduleNotification()
        }
        application.applicationIconBadgeNumber = 0
       
        CharacterManager.shared.loadData()
        SoundManager.shared.loadData()
        
        //counting launch app number
        ApplicationManager.shared.launchAppNumber = ApplicationManager.shared.launchAppNumber + 1
        
        return true
    }


    let kEnterBackground = "kEnterBackground"
    func applicationDidBecomeActive(_ application: UIApplication) {
        if UserDefaults.standard.bool(forKey: kEnterBackground) {
            GGAdmob.shared.showAppOpenAd()
            UserDefaults.standard.set(false, forKey: kEnterBackground)
            UserDefaults.standard.synchronize()
            print("hien thi quang cao App Open Ad")
            
        }
        
        if Server.webServer.isRunning {
            NotificationCenter.default.post(name: .reopenAppAfterStartWebserver, object: nil)
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        UserDefaults.standard.set(true, forKey: kEnterBackground)
        UserDefaults.standard.synchronize()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        GGAdmob.shared.requestAppOpenAd()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        return true
    }
}

extension AppDelegate {
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        content.title = appName
        content.body = NotificationUser.body
        content.sound = UNNotificationSound.default
        
        var count = 0
        DispatchQueue.main.async(execute: {
            count = UIApplication.shared.applicationIconBadgeNumber
        })
        
        content.badge = count + 1 as NSNumber
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: NotificationUser.timeInterval, repeats: true)
        
        let request = UNNotificationRequest(identifier: "identifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
