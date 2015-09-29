//
//  Character.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class Character: SKSpriteNode {

    private var isUsingPower = false
    private var powerDuration:Float = 0.0
    private var lastUpdatePower = NSDate()

    init (sprite:SKTexture) {

        super.init(texture: sprite, color: UIColor.clearColor(), size: sprite.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func walkRight () {
    
    
    }
    
    func walkLeft () {
    
    }

    func jump() {
    
    }
    
    func usePower() {
    
        if isUsingPower {
            self.activePower()
        }
        else {
            self.deactivatePower()
        }
        
    }
    
    private func activePower() {
        isUsingPower = true
        lastUpdatePower = NSDate()
    
    }
    private func deactivatePower() {
        isUsingPower = false
    }

    func updatePower(interval:NSDate) {
        
        //TODO calcular intervalo e substrair do power duration
        
        
    }
    
    
}