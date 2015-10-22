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
        
        let keySprite = SKTexture(imageNamed: "crate")
        super.init(sprite: keySprite)
        
        self.size = CGSizeMake(spriteWidth, spriteHeight)
        self.physicsBody?.categoryBitMask = objectCategory
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}