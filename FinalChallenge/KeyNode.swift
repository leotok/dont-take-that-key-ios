//
//  KeyNode.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 11/10/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import UIKit
import SpriteKit

class KeyNode: StaticObject {

    init() {
        
        let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        
        let keySprite = SKTexture(imageNamed: "key")
        super.init(sprite: keySprite)
        
        self.size = CGSizeMake(spriteWidth, spriteHeight)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = keyCategory
        self.physicsBody?.collisionBitMask = objectCategory
        self.physicsBody?.contactTestBitMask = playerCategory
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
