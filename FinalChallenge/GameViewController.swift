//
//  GameViewController.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 24/09/15.
//  Copyright (c) 2015 Hjlmt. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, ADMobDelegate {

    private let AdMob = ADMobSingleton.sharedIstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        let scene = MainMenu(size: skView.bounds.size)
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        self.view?.multipleTouchEnabled = true
        
        GameCenterManager.sharedInstance.vc = self
        GameCenterManager.sharedInstance.authenticateLocalPlayer()
        AdMob.delegate = self
        AdMob.loadInterstitial()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAd", name: "ShowAd", object: nil)
        
        
        skView.presentScene(scene)
    }
    
    func showAd() {
        AdMob.showInterstitial(self)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func didDismissAd() {
        
        //NSNotificationCenter.defaultCenter().postNotificationName("AdDismissed", object: nil)
        
    }
    
    
} //End of Class
