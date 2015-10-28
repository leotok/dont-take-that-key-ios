//
//  ControlTile.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 27/10/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class ControlTile: SKSpriteNode {
    
    var number = 0
    var activated = false
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.clearColor(), size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func createControlTile() -> ControlTile {
        
        let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
        
        let size = CGSizeMake(spriteWidth, spriteHeight)
        let tile = ControlTile(size: size)
        
        tile.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(spriteWidth,spriteHeight))
//        tile.physicsBody?.collisionBitMask = 0
        tile.physicsBody?.categoryBitMask = controlTileCategory
        tile.physicsBody?.contactTestBitMask = playerCategory
        tile.physicsBody?.dynamic = false

        return tile
    }
}