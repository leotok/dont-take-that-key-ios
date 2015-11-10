//
//  CrateNode.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 13/10/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import UIKit
import SpriteKit

class CrateNode: MovableObject {
    
    init() {
        
        let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        
        let sprite = SKTexture(imageNamed: "crate")
        super.init(sprite: sprite)
        
        self.size = CGSizeMake(spriteWidth, spriteHeight)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size, center: CGPointMake(0,0))
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = objectCategory
        self.physicsBody?.collisionBitMask = 1 | 2
        self.physicsBody?.restitution = 0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}