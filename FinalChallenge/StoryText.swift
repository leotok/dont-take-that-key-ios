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
    
    override init() {
    
        super.init()

        self.zPosition = ZPositionEnum.Labels.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getStoryforLevel(index: Int, size: CGSize) -> StoryText {
        
        let story = StoryText()
        
        switch (index) {
            
        case 1:
            
            let line1 = StoryLabelNode(text: NSLocalizedString("Level1.1", comment: ""))
            line1.position.x = size.width / 2
            line1.position.y = size.height / 1.5
            
            let line2 = StoryLabelNode(text: NSLocalizedString("Level1.2", comment: ""))
            line2.position.x = size.width / 2
            line2.position.y = size.height / 1.7

            story.addChild(line1)
            story.addChild(line2)
            
            break
            
        case 2:
            
            break
            
        default:
            break
        }
        
        return story
    }
    
    class func reactToControlTile(tile: ControlTile, level: Int, story: StoryText) {
        
        switch (level) {
            
        case 1:
            
            if tile.number == 1 {
                story.removeAllChildren()
                
                let line1 = StoryLabelNode(text: NSLocalizedString("Level1.3", comment: ""))
                line1.position.x = UIScreen.mainScreen().bounds.width / 2
                line1.position.y = UIScreen.mainScreen().bounds.height / 1.5
                
                let line2 = StoryLabelNode(text: NSLocalizedString("Level1.4", comment: ""))
                line2.position.x = UIScreen.mainScreen().bounds.width / 2
                line2.position.y = UIScreen.mainScreen().bounds.height / 1.7
                
                story.addChild(line1)
                story.addChild(line2)
                
            }
            break
            
        case 2:
            
            break
            
        default:
            break

        }
    }
    
    
}