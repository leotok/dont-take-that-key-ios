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
    internal var powerDuration:Double = 10.0
    private var lastUpdatePower = NSDate()
    private var idleTextures:[SKTexture]!
    internal var walkTextures:[SKTexture]!
    internal var jumpTextures:[SKTexture]!
    
    let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height * 2 / 12.9375
    let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height * 2  / 12.9375
    
    init (sprite:[SKTexture]) {
        self.idleTextures = sprite
        let spriteSize = sprite.first?.size()
        let charSize = CGSizeMake((spriteSize?.width)! / 1.5, (spriteSize?.height)! / 1.5)
        super.init(texture: sprite.first, color: UIColor.clearColor(), size: charSize)
        physicsBody = SKPhysicsBody(rectangleOfSize: charSize)
        physicsBody?.categoryBitMask = playerCategory
        physicsBody?.collisionBitMask = objectCategory | hazardCategory | clockHandCategory | crateCategory
        physicsBody?.contactTestBitMask = keyCategory | doorCategory | objectCategory | hazardCategory | controlTileCategory | clockHandCategory |  crateCategory
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0

        self.zPosition = ZPositionEnum.Character.rawValue

        name = "character"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWalkingTextures(sprites: [SKTexture]){
        self.walkTextures = sprites
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
    
    func updatePower(sender:AnyObject) {
        print("UPDATING POWER")
        if isUsingPower {
            let elapsedTime = NSDate().timeIntervalSinceDate(lastUpdatePower)
            self.powerDuration = self.powerDuration - elapsedTime
            print(powerDuration)
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
        return self.powerDuration / self.initialPowerDuration
    }
    
    /* INTERNAL AND PRIVATE METHODS */
    
    internal func activatePower() {

        if powerDuration > 0.0 {
            isUsingPower = true
            lastUpdatePower = NSDate()
            let perform = SKAction.performSelector("updatePower:", onTarget: self)
            let wait = SKAction.waitForDuration(1)
        
            let update = SKAction.repeatActionForever(SKAction.sequence([wait,perform]))
            self.runAction(update, withKey: "UpdatePower")
        }
    }
    internal func deactivatePower() {
        let elapsedTime = NSDate().timeIntervalSinceDate(lastUpdatePower)
        self.powerDuration = self.powerDuration - elapsedTime
        print("powerDuration")
        isUsingPower = false
        self.removeActionForKey("UpdatePower")
    }
    
    
    
    
} //End of Class