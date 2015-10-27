//
//  StoryText.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class StoryText: SKNode {
    
    
    init(text:String) {
    
        let label = SKLabelNode(text: text)
        label.fontName = "Avenir"
        label.fontSize = 20
        label.fontColor = UIColor.whiteColor()
        
        super.init()
        
        self.zPosition = ZPositionEnum.Labels.rawValue
    
        self.addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}