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
    case Locked = "lock 2"
    
}

class LevelButton: SKSpriteNode{
    
    private(set) var level = -1
    var type: LevelButtonType!
    
    init(type: LevelButtonType, level:Int) {
        
        self.level = level
        self.type = type
//        let texture = SKTexture(imageNamed: type.rawValue)
        let texture = SKTexture(imageNamed: "1")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(15, 15))
        self.zPosition = ZPositionEnum.Button.rawValue
        self.name = "LevelButton"

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
