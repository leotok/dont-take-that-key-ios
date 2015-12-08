//
//  GameCharacter.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class GameCharacter: SKSpriteNode {
    
    var isJumping = false
    private var isUsingPower = false
    internal var initialPowerDuration:Double = 10.0
    internal var powerDurationArray:[Double] = [10.0,10.0,10.0,5.0,10.0,1.9,5.0,10.0,10.0,10.0,10.0,10.0,10.0,10.0,10.0,10.0,10.0,10.0,]
    internal var powerDuration:Double = 0
    var lastUpdatePower = NSDate()
    private var idleTextures:[SKTexture]!
    internal var walkTextures:[SKTexture]!
    internal var jumpTextures:[SKTexture]!
    
    let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height * 2 / 12.9375
    let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height * 2  / 12.9375
    
    init (sprite:[SKTexture], level: Int) {
        self.idleTextures = sprite
        let spriteSize = sprite.first?.size()
        let charSize = CGSizeMake((spriteSize?.width)! / 1.6, (spriteSize?.height)! / 1.6)
        super.init(texture: sprite.first, color: UIColor.clearColor(), size: charSize)
        physicsBody = SKPhysicsBody(rectangleOfSize: charSize)
        physicsBody?.categoryBitMask = playerCategory
        physicsBody?.collisionBitMask = objectCategory | hazardCategory | clockHandCategory | crateCategory | clockBlockCategory | fallingGroundCategory
        physicsBody?.contactTestBitMask = keyCategory | doorCategory | objectCategory | hazardCategory | controlTileCategory | clockHandCategory |  crateCategory | fallingGroundCategory
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0
        
        powerDuration = powerDurationArray[level - 1]
        initialPowerDuration = powerDuration

        self.zPosition = ZPositionEnum.Character.rawValue

        name = "character"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWalkingTextures(sprites: [SKTexture]){
        self.walkTextures = sprites
    }
    
    func charIsUsingPower() -> Bool {
        
        return isUsingPower
    }
    
    func walkRight () {
        self.removeActionForKey("Idle")
        let moveX = SKAction.moveByX(30, y: 0, duration: 0.2)
        let animate = SKAction.animateWithTextures(walkTextures, timePerFrame: 0.15)
    
        self.xScale = 1
        self.runAction(SKAction.repeatActionForever(moveX), withKey:"Walk")
        self.runAction(SKAction.repeatActionForever(animate),withKey: "Animate")
    }
    
    func walkLeft () {
        self.removeActionForKey("Idle")
        let moveX = SKAction.moveByX(-30, y: 0, duration: 0.2)
        let animate = SKAction.animateWithTextures(walkTextures, timePerFrame: 0.15)
        
        self.xScale = -1
        self.runAction(SKAction.repeatActionForever(moveX), withKey:"Walk")
        self.runAction(SKAction.repeatActionForever(animate),withKey: "Animate")
    }

    func stopWalking() {
        self.removeActionForKey("Walk")
        self.removeActionForKey("Animate")
        physicsBody?.velocity = CGVectorMake(0, 0)
        self.texture = idleTextures[0]
        let wait = SKAction.waitForDuration(3)
        let animate = SKAction.animateWithTextures([idleTextures[1],idleTextures[0]], timePerFrame: 0.2)
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait,animate])), withKey:"Idle")
    }
    
    func jump() {
        
        if !isJumping {
            jumpTextures = self.idleTextures
            //let animate = SKAction.animateWithTextures(jumpTextures, timePerFrame: 0.2)
            //let jumpAction = SKAction.group([animate,impulse])
            //self.runAction(jumpAction, withKey:"Jump")

            let impulse = SKAction.applyImpulse(CGVectorMake(0, 15), duration: 0.1)
            isJumping = true
            self.runAction(impulse, withKey: "Jump")
        }
    
    }
    
    func stopImpulse(){
        self.removeActionForKey("Jump")
    }
    
    func reachedGround() {
        isJumping = false
    }
    
    
    func usePower() {
    
        if !isUsingPower {
            self.activatePower()
        }
        else {
            self.deactivatePower()
        }
        
    }
    
    func updatePower() {
        
        if isUsingPower {
            let elapsedTime = NSDate().timeIntervalSinceDate(self.lastUpdatePower)
            self.powerDuration = self.powerDuration - elapsedTime
            lastUpdatePower = NSDate()
            if self.powerDuration <= 0.0 {
                self.deactivatePower()
            }
            NSNotificationCenter.defaultCenter().postNotificationName("UpdatePowerBar", object: nil)
        }
    }
    
    func die() {
    
    }
    
    func getPercentagePower () ->Double {
        if powerDuration > 0 {
            return self.powerDuration / self.initialPowerDuration
        }
        else {
            return 0.0
        }
    }
    
    /* INTERNAL AND PRIVATE METHODS */
    
    internal func activatePower() {

        if powerDuration > 0.0 {
            self.isUsingPower = true
            self.lastUpdatePower = NSDate()
            
            let perform = SKAction.performSelector("updatePower", onTarget: self)
    
            
            let wait = SKAction.waitForDuration(0.1)
        
            let updatePowerDuration = SKAction.repeatActionForever(SKAction.sequence([wait,perform]))
            self.runAction(updatePowerDuration, withKey: "UpdatePower")
        }
    }
    internal func deactivatePower() {
        let elapsedTime = NSDate().timeIntervalSinceDate(lastUpdatePower)
        self.powerDuration = self.powerDuration - elapsedTime
        NSNotificationCenter.defaultCenter().postNotificationName("UpdatePowerBar", object: nil)
        isUsingPower = false
        self.removeActionForKey("UpdatePower")
    }
    
    
    
} //End of Class