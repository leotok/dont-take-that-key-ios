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
        
        let keySprite = SKTexture(imageNamed: "Key")
        super.init(sprite: keySprite)
        
        self.size = CGSizeMake(spriteWidth, spriteHeight)
        self.physicsBody?.categoryBitMask = keyCategory
        physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.collisionBitMask = objectCategory
        self.physicsBody?.contactTestBitMask = playerCategory
        
        let action = SKAction.moveBy(CGVectorMake(0, 5), duration: 1)
        self.runAction(SKAction.repeatActionForever((SKAction.sequence([action,action.reversedAction()]))))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
