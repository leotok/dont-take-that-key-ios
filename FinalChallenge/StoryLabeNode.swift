//
//  StoryLabeNode.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 27/10/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class StoryLabelNode: SKLabelNode {
    
    init(text: String) {
        
        super.init()
        
        self.text = text
        self.fontSize = 14
        self.fontColor = SKColor.whiteColor()
        self.fontName = "Avenir"

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}