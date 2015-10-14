//
//  DoorNode.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 11/10/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import UIKit
import SpriteKit

class DoorNode: StaticObject {

        init() {
        
        let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height * 2 / 12.9375
        let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height * 2 / 12.9375
        
        let doorSprite = SKTexture(imageNamed: "door")
        super.init(sprite: doorSprite)
        
        self.anchorPoint = CGPointMake(0.25, 0.25)
        self.size = CGSizeMake(spriteWidth, spriteHeight)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = doorCategory
        self.physicsBody?.collisionBitMask = objectCategory
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
