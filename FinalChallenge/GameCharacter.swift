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
        let spriteSize = sprite.first?.size()
        let charSize = CGSizeMake((spriteSize?.width)! / 1.5, (spriteSize?.height)! / 1.5)
        super.init(texture: sprite.first, color: UIColor.clearColor(), size: charSize)
        //physicsBody = SKPhysicsBody(texture: sprite.first!, size: CGSizeMake(spriteWidth, spriteHeight))
        physicsBody = SKPhysicsBody(rectangleOfSize: charSize)
        physicsBody?.categoryBitMask = playerCategory
        physicsBody?.collisionBitMask = objectCategory | hazardCategory
        physicsBody?.contactTestBitMask = keyCategory | doorCategory | objectCategory | hazardCategory
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0

        //physicsBody?.usesPreciseCollisionDetection = true
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
        let animate = SKAction.animateWithTextures([paradoTextures[1],paradoTextures[0]], timePerFrame: 0.2)
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait,animate])), withKey:"Idle")
        
        
    }
    
    func jump() {
        
        if !isJumping {
            jumpTextures = self.paradoTextures
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