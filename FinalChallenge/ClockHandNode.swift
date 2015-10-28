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
        
        let keySprite = SKTexture(imageNamed: "ponteiroGrande")
        super.init(sprite: keySprite)
        
        self.size = CGSizeMake(spriteWidth, spriteHeight)
        self.physicsBody?.categoryBitMask = ClockHandCategory
        physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.collisionBitMask = playerCategory
        self.physicsBody?.contactTestBitMask = 0
        self.zPosition = ZPositionEnum.ClockHand.rawValue
        
        self.anchorPoint = CGPointMake(0, 0.5 )
        let action = (SKAction.rotateByAngle(2 * 3.14 , duration: 2))
        self.runAction(SKAction.repeatActionForever(action))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}