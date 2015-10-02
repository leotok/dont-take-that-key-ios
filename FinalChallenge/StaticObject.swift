//
//  StaticObject.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class StaticObject: GenericObject {
    
    override init(sprite: SKTexture) {

        super.init(sprite: sprite)
        zPosition = 10
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(64, 64))
        physicsBody?.categoryBitMask = 2
        physicsBody?.collisionBitMask = 1 | 2
        physicsBody?.affectedByGravity = false
        physicsBody?.allContactedBodies()
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0
        physicsBody?.dynamic = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}