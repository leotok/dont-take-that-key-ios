//
//  File.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 30/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

enum LevelButtonType: String {
    
    case Sam = "clock"
    case Shrink = "freud"
    case Ellie = "fat-bottom-girls"
    case AllCharacters = "allchar"
    
}

class LevelButton: SKSpriteNode{
    
    init(type: LevelButtonType) {
        
        let texture = SKTexture(imageNamed: type.rawValue)
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(40, 40))
        self.zPosition = 1

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
