//
//  AmpulhetaNode.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 03/11/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import UIKit
import SpriteKit

class AmpulhetaNode: MovableObject {

    init() {
        
        let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height * 3 / 12.9375
        let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height * 3 / 12.9375
        
        let sprite = SKTexture(imageNamed: "Ampulheta")
        super.init(sprite: sprite)
        
        self.size = CGSizeMake(spriteWidth, spriteHeight)
        self.physicsBody = SKPhysicsBody(texture: sprite, size: sprite.size())
//        self.physicsBody?.usesPreciseCollisionDetection
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = objectCategory
        self.physicsBody?.restitution = 0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
