//
//  SpikeNode.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 13/10/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import UIKit
import SpriteKit

class SpikeNode: StaticObject {
    
    init() {
        
        let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        
        let keySprite = SKTexture(imageNamed: "spike")
        super.init(sprite: keySprite)
        
        self.size = CGSizeMake(spriteWidth, spriteHeight)
        physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = hazardCategory
        self.physicsBody?.collisionBitMask = objectCategory | playerCategory
        self.physicsBody?.contactTestBitMask = playerCategory
        self.zPosition = ZPositionEnum.Spike.rawValue
    }
    
    func activeMoviment() {
    
        let width = self.texture!.size().height
        
        let moveY = SKAction.moveBy(CGVectorMake(0,-width), duration: 0.3)
        let reverseY = SKAction.reversedAction(moveY);
        let wait = SKAction.waitForDuration(2);
        
        let moviment = SKAction.sequence([moveY,wait,reverseY()])
        self.runAction(SKAction.repeatActionForever(moviment))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}