//
//  GameCenterManager.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import GameKit

class GameCenterManager {
    
    //private var leaderboardIdentifier: String? = nil
    private var gameCenterEnabled: Bool = false
    var gcEnabled = false
    private var localPlayer:GKLocalPlayer!
    var vc:UIViewController!
    
    class var sharedInstance:GameCenterManager{
        get {
            struct _Singleton {
                static let instance = GameCenterManager()
            }
            return _Singleton.instance
        }
    }
    
    private init(){
        //println("Singleton 'GaßmeCenterManager' instanciado.")
    }
    
    func authenticateLocalPlayer()
    {
         localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(GameViewController, error) -> Void in
            
            if ((GameViewController) != nil) {
                self.vc!.presentViewController(GameViewController!, animated: true, completion: nil)
            }
            else if (self.localPlayer.authenticated) {
                print("Ta autenticado game center ")
                self.gcEnabled = true
                
                self.localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({(leaderBoardIdentifier: String?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    }
                })
                
            }
            else {
                self.gcEnabled = false;
                print("Deu ruim no game center, desabilitando...")
                print(error)
            }
        }
    }

    func postAchievement(id:String) {
     
        if self.localPlayer.authenticated {
            
            let gkachiev = GKAchievement(identifier: id)
            gkachiev.percentComplete = 100
            gkachiev.showsCompletionBanner = true
            
            GKAchievement.reportAchievements([gkachiev], withCompletionHandler: {(error:NSError?) ->Void in
                if error != nil {
                    print(error)
                }
            })
            print("reportado achiev")
            
            
        }
        else {
            print("nao autenticado")
        }
        
        
    }
    
    
}