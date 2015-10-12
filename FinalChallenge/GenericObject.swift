//
//  GenericObject.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit


class GenericObject: SKSpriteNode {
 
    init (sprite:SKTexture) {
        
        let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        
        super.init(texture: sprite, color: UIColor.clearColor(), size: CGSizeMake(spriteWidth , spriteHeight))
        zPosition = 10
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(spriteWidth,spriteHeight))
        physicsBody?.categoryBitMask = 2
        physicsBody?.collisionBitMask = 1 | 2
        physicsBody?.allContactedBodies()
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}