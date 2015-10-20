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
    private var powerDuration:Float = 0.0
    private var lastUpdatePower = NSDate()
    private var paradoTextures:[SKTexture]!
    internal var walkTextures:[SKTexture]!
    internal var jumpTextures:[SKTexture]!
    
    let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height * 2 / 12.9375
    let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height * 2  / 12.9375
    
    init (sprite:[SKTexture]) {
        self.paradoTextures = sprite
        super.init(texture: sprite[1], color: UIColor.clearColor(), size: CGSizeMake(spriteWidth, spriteHeight))
        physicsBody = SKPhysicsBody(texture: sprite[0], size: CGSizeMake(spriteWidth, spriteHeight))
        physicsBody?.categoryBitMask = playerCategory
        physicsBody?.collisionBitMask = objectCategory | hazardCategory
        physicsBody?.contactTestBitMask = keyCategory | doorCategory | objectCategory | hazardCategory
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0

        physicsBody?.usesPreciseCollisionDetection = true
        self.zPosition = 1

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
        //walkTextures = [idleTexture,idleTexture,idleTexture]
        let moveX = SKAction.moveByX(30, y: 0, duration: 0.2)
        let animate = SKAction.animateWithTextures(walkTextures, timePerFrame: 0.15)
        //let walkAction = SKAction.group([moveX,animate])
    
        self.xScale = 1
        self.runAction(SKAction.repeatActionForever(moveX), withKey:"Walk")
        self.runAction(SKAction.repeatActionForever(animate),withKey: "Animate")
    }
    
    func walkLeft () {
        self.removeActionForKey("Idle")
        //walkTextures = [idleTexture,idleTexture,idleTexture]
        let moveX = SKAction.moveByX(-30, y: 0, duration: 0.2)
        let animate = SKAction.animateWithTextures(walkTextures, timePerFrame: 0.15)
      //  let walkAction = SKAction.group([moveX,animate])
        
        self.xScale = -1
        self.runAction(SKAction.repeatActionForever(moveX), withKey:"Walk")
        self.runAction(SKAction.repeatActionForever(animate),withKey: "Animate")
    }

    func stopWalking() {
        self.removeActionForKey("Walk")
        self.removeActionForKey("Animate")
        physicsBody?.velocity = CGVectorMake(0, 0)
        let wait = SKAction.waitForDuration(3)
        let animate = SKAction.animateWithTextures(self.paradoTextures, timePerFrame: 0.2)
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([animate,wait])), withKey:"Idle")
        
        
    }
    
    func jump() {
        
        if !isJumping {
            jumpTextures = self.paradoTextures
            let animate = SKAction.animateWithTextures(jumpTextures, timePerFrame: 0.2)
            let impulse = SKAction.applyImpulse(CGVectorMake(0, 15), duration: 0.1)
            let jumpAction = SKAction.group([animate,impulse])
            isJumping = true
            self.runAction(jumpAction, withKey:"Jump")
        }
    
    }
    
    func stopImpulse(){
        self.removeActionForKey("Jump")
    }
    
    func reachedGround() {
        isJumping = false
    }
    
    
    func usePower() {
        print("by the power of GraySkull")
    
        if !isUsingPower {
            self.activatePower()
        }
        else {
            self.deactivatePower()
        }
        
    }
    
    func updatePower(interval:NSDate) {
        
        //TODO calcular intervalo e substrair do power duration
        
        
    }
    
    func die() {
    
    }
    
    /* INTERNAL AND PRIVATE METHODS */
    
    internal func activatePower() {
        print("I have the power")
        isUsingPower = true
        lastUpdatePower = NSDate()
    
    }
    internal func deactivatePower() {
        isUsingPower = false
    }
    
} //End of Class