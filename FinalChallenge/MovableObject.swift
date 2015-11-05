//
//  MovableObject.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class MovableObject: GenericObject {
    
    override init(sprite: SKTexture) {
        
        super.init(sprite: sprite)
        physicsBody?.affectedByGravity = true
        physicsBody?.dynamic = true
        physicsBody?.categoryBitMask = 2
        physicsBody?.collisionBitMask = 1 | 2
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
}