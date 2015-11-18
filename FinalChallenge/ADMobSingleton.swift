//
//  File.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 18/11/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

protocol ADMobDelegate {
    func didDissmissAd()
}

class ADMobSingleton:NSObject, GADInterstitialDelegate  {

    static let sharedIstance = ADMobSingleton()
    var interstitial: GADInterstitial?
    var delegate:ADMobDelegate?
    
    private override init() {}
    
    func loadInterstitial() {
        if interstitial != nil {return}
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3256183457519570/5940964046")
        interstitial!.delegate = self
        
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made. GADInterstitial automatically returns test ads when running on a
        // simulator.
        interstitial!.loadRequest(GADRequest())
    }
    
    func interstitialDidFailToReceiveAdWithError (
        interstitial: GADInterstitial,
        error: GADRequestError) {
            print("interstitialDidFailToReceiveAdWithError: %@" + error.localizedDescription)
    }
    
    func interstitialDidDismissScreen (interstitial: GADInterstitial) {
        print("interstitialDidDismissScreen")
        self.interstitial = nil
        self.delegate?.didDissmissAd()
    }
    
    func showInterstitial(rootViewController:UIViewController) {
        if (interstitial != nil && interstitial!.isReady) {
            interstitial!.presentFromRootViewController(rootViewController)
        }
        else {
            print("The interstitial didn't finish loading or failed to load")
        }
    }
    
    
    
    

} //End of Class