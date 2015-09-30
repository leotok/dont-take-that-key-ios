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
    
    var isJumping = false
    private var isUsingPower = false
    private var powerDuration:Float = 0.0
    private var lastUpdatePower = NSDate()
    private var idleTexture:SKTexture!
    internal var walkTextures:[SKTexture]!
    internal var jumpTextures:[SKTexture]!
    
    init (sprite:SKTexture) {
        idleTexture = sprite
        super.init(texture: sprite, color: UIColor.clearColor(), size: sprite.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func walkRight () {
        let moveX = SKAction.moveByX(100, y: 0, duration: 0.3)
        let animate = SKAction.animateWithTextures(walkTextures, timePerFrame: 0.2)
        let walkAction = SKAction.group([moveX,animate])
    
        self.xScale = 1
        self.runAction(SKAction.repeatActionForever(walkAction), withKey:"Walk")
    }
    
    func walkLeft () {
        let moveX = SKAction.moveByX(-100, y: 0, duration: 0.3)
        let animate = SKAction.animateWithTextures(walkTextures, timePerFrame: 0.2)
        let walkAction = SKAction.group([moveX,animate])
        
        self.xScale = -1
        self.runAction(SKAction.repeatActionForever(walkAction), withKey:"Walk")
    }

    func stopWalking() {
        self.removeActionForKey("Walk")
        self.texture = idleTexture
    }
    
    
    func jump() {
        
        if !isJumping {
            let animate = SKAction.animateWithTextures(jumpTextures, timePerFrame: 0.2)
            let impulse = SKAction.applyImpulse(CGVectorMake(0, 250), duration: 1)
            let jumpAction = SKAction.group([animate,impulse])
            isJumping = true
            self.runAction(jumpAction, withKey:"Jump")
        }
    
    }
    
    func reachedGround() {
        self.removeActionForKey("Jump")
        isJumping = false
    }
    
    
    func usePower() {
    
        if isUsingPower {
            self.activePower()
        }
        else {
            self.deactivatePower()
        }
        
    }
    
    func updatePower(interval:NSDate) {
        
        //TODO calcular intervalo e substrair do power duration
        
        
    }
    
    /* INTERNAL AND PRIVATE METHODS */
    
    internal func activePower() {
        isUsingPower = true
        lastUpdatePower = NSDate()
    
    }
    internal func deactivatePower() {
        isUsingPower = false
    }
    
} //End of Class