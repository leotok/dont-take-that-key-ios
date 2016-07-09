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
    
    let screenHeight = UIScreen.mainScreen().bounds.width
    
    var isJumping = false
    private var isUsingPower = false
    internal var initialPowerDuration:Double = 10.0
    internal var powerDurationArray:[Double]!
    internal var powerDuration:Double = 0
    var lastUpdatePower = NSDate()
    internal var idleTextures:[SKTexture]!
    internal var walkTextures:[SKTexture]!
    internal var jumpTextures:[SKTexture]!
    internal var idlePowerTexture:SKTexture!
    
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
        
        let t10:Double = Double(screenHeight / 56.8)
        let t5:Double = Double(screenHeight / 113.6)
        let t1_9:Double = Double(screenHeight / 29.895)
        
        powerDurationArray = [t10 ,t10 ,t10 ,t5 ,t10 ,t1_9 ,t5 ,t10 ,t10 ,t10 , t10 ,t10,t10 ,t10 ,t10 ,t10 ,t10 ,t10]
        
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
        let moveX = SKAction.moveByX(screenHeight / 18.93 , y: 0, duration: 0.2)
        let animate = SKAction.animateWithTextures(walkTextures, timePerFrame: 0.15)
    
        self.xScale = 1
        self.runAction(SKAction.repeatActionForever(moveX), withKey:"Walk")
        self.runAction(SKAction.repeatActionForever(animate),withKey: "Animate")
    }
    
    func walkLeft () {
        self.removeActionForKey("Idle")
        let moveX = SKAction.moveByX(-screenHeight / 18.93, y: 0, duration: 0.2)
        let animate = SKAction.animateWithTextures(walkTextures, timePerFrame: 0.15)
        
        self.xScale = -1
        self.runAction(SKAction.repeatActionForever(moveX), withKey:"Walk")
        self.runAction(SKAction.repeatActionForever(animate),withKey: "Animate")
    }

    func stopWalking() {
        self.removeActionForKey("Walk")
        self.removeActionForKey("Animate")
        physicsBody?.velocity = CGVectorMake(0, 0)
        if self.isUsingPower {
            self.texture = self.idlePowerTexture
        }
        else {
            self.texture = idleTextures[0]
            let wait = SKAction.waitForDuration(3)
            let animate = SKAction.animateWithTextures([idleTextures[1],idleTextures[0]], timePerFrame: 0.2)
            self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait,animate])), withKey:"Idle")
        }
    }
    
    func jump() {
        
        if !isJumping {
            jumpTextures = self.idleTextures
            //let animate = SKAction.animateWithTextures(jumpTextures, timePerFrame: 0.2)
            //let jumpAction = SKAction.group([animate,impulse])
            //self.runAction(jumpAction, withKey:"Jump")

            self.physicsBody?.velocity.dy = 0
            let impulse = SKAction.applyImpulse(CGVectorMake(0, screenHeight / 37.867), duration: 0.1)
            print(screenHeight / 37.568)
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
            self.texture = idleTextures[0]
            let wait = SKAction.waitForDuration(3)
            let animate = SKAction.animateWithTextures([idleTextures[1],idleTextures[0]], timePerFrame: 0.2)
            self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait,animate])), withKey:"Idle")
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
            self.texture = self.idlePowerTexture
            self.removeActionForKey("Idle")

            self.isUsingPower = true
            self.lastUpdatePower = NSDate()
            
            let perform = SKAction.performSelector(#selector(GameCharacter.updatePower), onTarget: self)
    
            
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