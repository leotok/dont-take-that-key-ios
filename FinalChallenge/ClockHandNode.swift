//
//  ClockHandNode.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 28/10/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class ClockHandNode: StaticObject {
    
    init() {
        
        let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height * 4 / 12.9375
        let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height * 4 / 12.9375
        
        let sprite = SKTexture(imageNamed: "ponteiroPequeno")
        super.init(sprite: sprite)
        
       // self.anchorPoint = CGPointMake(0.1, 0.53 )
        
        size = CGSizeMake(spriteWidth, spriteHeight)
        physicsBody = SKPhysicsBody(texture: sprite, size: sprite.size())
        physicsBody?.categoryBitMask = clockHandCategory
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.collisionBitMask = playerCategory
        physicsBody?.contactTestBitMask = playerCategory
        physicsBody?.affectedByGravity = false
        physicsBody?.dynamic = false
        zPosition = ZPositionEnum.ClockHand.rawValue
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0
        
        let action = (SKAction.rotateByAngle(2 * 3.14 , duration: Double(Int.random(2...4))))
        self.runAction(SKAction.repeatActionForever(action))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}