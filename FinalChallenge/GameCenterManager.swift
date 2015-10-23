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
    
    private var leaderboardIdentifier: String? = nil
    private var gameCenterEnabled: Bool = false
    
    class var sharedInstance:GameCenterManager{
        get {
            struct _Singleton {
                static let instance = GameCenterManager()
            }
            return _Singleton.instance
        }
    }
    
    private init(){
        //println("Singleton 'GameCenterManager' instanciado.")
    }
    
    func authenticateLocalPlayer() ->Bool {
        let localPlayer : GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(GameViewController, error) -> Void in
            
            if ((GameViewController) != nil) {
                self.presentViewController(GameViewController!, animated: true, completion: nil)
            }
            else if (localPlayer.authenticated) {
                print("Ta autenticado game center ")
                self.gcEnabled = true
                
                //get the default leaderboard id
                //                localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderBoardIdentifier: String!, error: NSError!) -> Void in
                //                    if error != nil {
                //                        print(error)
                //                    }
                //                    else {
                //                        self.gcDefaultLeaderBoard = leaderBoardIdentifier
                //                    }
                //                })
                localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({(leaderBoardIdentifier: String?, error: NSError?) -> Void in
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
    
}