//
//  GoogleAdmob.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import GoogleMobileAds
import MTSDK

class GGAdmob: NSObject {
    static let shared : GGAdmob = GGAdmob()
    var interstitial: GADInterstitialAd?
    var appOpenAd: GADAppOpenAd?
    
    func loadInterstitial() {
        if self.interstitial != nil {return}
        print("requesting ads mod.....")
        GADInterstitialAd.load(withAdUnitID: GoogleAds.interstitialAdUnitID, request: GADRequest(), completionHandler: { [self] ad,error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            self.interstitial = ad
            self.interstitial?.fullScreenContentDelegate = self
        })
    }
    
    func canShowAd() -> Bool {
        return self.interstitial != nil
    }
    
    func showInterstitial(){
        if let ad = self.interstitial {
            print("showing ads mod....")
            if let topViewController = topViewController {
                ad.present(fromRootViewController: topViewController)
            }
        } else {
            print("interstitial is nil")
            self.loadInterstitial()
        }
    }

}

//MARK: Open Ads
extension GGAdmob: GADFullScreenContentDelegate {
    func requestAppOpenAd() {
        print("request ads")
        self.appOpenAd = nil
        let request = GADRequest()
        GADAppOpenAd.load(withAdUnitID: GoogleAds.openAdUnitID, request: request, orientation: .portrait, completionHandler: { appOpenAd, error in
            if error != nil {
                print("Failed to load app open ad: \(error?.localizedDescription ?? "")")
                return
            }
            self.appOpenAd = appOpenAd
            self.appOpenAd?.fullScreenContentDelegate = self
        })
    }
    
    func showAppOpenAd() {
        print("show ad")
        if let ad = self.appOpenAd {
            if let topViewController = topViewController {
                ad.present(fromRootViewController: topViewController)
            }
        } else {
            print("request new ad")
            self.requestAppOpenAd()
        }
    }
    
    //MARK: Delegate
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("didFailToPresentFullScreenCContentWithError: \(error.localizedDescription)")
    }
    
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("adDidPresentFullScreenContent")
    }
    
    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
        print("GADFullScreenPresentingAd")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("adDidDismissFullScreenContent")
        NotificationCenter.default.post(name: .interstitialDidDismiss, object: nil, userInfo: nil)
        self.interstitial = nil
        self.loadInterstitial()
        
    }
}
