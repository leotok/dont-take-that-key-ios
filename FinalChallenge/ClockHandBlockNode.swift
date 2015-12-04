//
//  ClockHandBlockNode.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 28/10/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class ClockHandBlockNode: StaticObject {
    
    init() {
        
        //        let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height  / 12.9375
        //        let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        
        let sprite = SKTexture(imageNamed: "ponteiroBlock")
        super.init(sprite: sprite)
        
        
        size = sprite.size()
        physicsBody = SKPhysicsBody(texture: sprite, size: sprite.size())
        physicsBody?.categoryBitMask = clockBlockCategory
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.collisionBitMask = playerCategory | objectCategory
        physicsBody?.contactTestBitMask = playerCategory | objectCategory
        physicsBody?.affectedByGravity = false
        physicsBody?.dynamic = true
        zPosition = ZPositionEnum.ClockHand.rawValue
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0
        physicsBody?.friction = 2
        physicsBody?.linearDamping = 20
        
        self.runAction(SKAction.applyImpulse(CGVectorMake(0, -50), duration: 1))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}