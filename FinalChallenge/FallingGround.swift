//
//  FallingBlock.swift
//  Dont take that Key
//
//  Created by Hugo Manhães on 12/7/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class FallingGround: StaticObject {
    
    override init(sprite: SKTexture) {
        
        let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        
        super.init(sprite: sprite)
        
        size = sprite.size()
        physicsBody = SKPhysicsBody(texture: sprite, size: CGSizeMake(spriteWidth, spriteHeight))
        physicsBody?.categoryBitMask = fallingGroundCategory
        physicsBody?.collisionBitMask = playerCategory
        physicsBody?.contactTestBitMask = playerCategory
        physicsBody?.affectedByGravity = false
        physicsBody?.dynamic = false
        zPosition = ZPositionEnum.Tile.rawValue
        physicsBody?.allowsRotation = false
    }
    
    func fall(){
        physicsBody?.affectedByGravity = true
        physicsBody?.dynamic = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}