//
//  GameCenterManager.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation


class GameCenterManager {
    
    
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
    
    func connect()->Bool {
        return true
    }
    
    
}