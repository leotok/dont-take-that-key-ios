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
            
            let line1 = StoryLabelNode(text: NSLocalizedString("Level2.1", comment: ""))
            line1.position.x = size.width / 2
            line1.position.y = size.height / 1.2
            
            let line2 = StoryLabelNode(text: NSLocalizedString("Level2.2", comment: ""))
            line2.position.x = size.width / 2
            line2.position.y = size.height / 1.4
            
            story.addChild(line1)
            story.addChild(line2)
            break
        case 3:
            
            let line1 = StoryLabelNode(text: NSLocalizedString("Level3.1", comment: ""))
            line1.position.x = size.width / 2
            line1.position.y = size.height / 1.2
            
            let line2 = StoryLabelNode(text: NSLocalizedString("Level3.2", comment: ""))
            line2.position.x = size.width / 2
            line2.position.y = size.height / 1.4
            
            story.addChild(line1)
            story.addChild(line2)
            break
        default:
            break
        }
        
        return story
    }
    
    func reactToControlTile(tile: ControlTile, level: Int) {

        self.removeAllChildren()
        
        switch (level) {
        case 1:
            
            if tile.number == 1 {
                
                let line1 = StoryLabelNode(text: NSLocalizedString("Level1.3", comment: ""))
                line1.position.x = UIScreen.mainScreen().bounds.width / 2
                line1.position.y = UIScreen.mainScreen().bounds.height / 1.5
                
                let line2 = StoryLabelNode(text: NSLocalizedString("Level1.4", comment: ""))
                line2.position.x = UIScreen.mainScreen().bounds.width / 2
                line2.position.y = UIScreen.mainScreen().bounds.height / 1.7
                
                self.addChild(line1)
                self.addChild(line2)
                
            }
            else if tile.number == 2 {
                
                let line1 = StoryLabelNode(text: NSLocalizedString("Level1.5", comment: ""))
                line1.position.x = UIScreen.mainScreen().bounds.width / 2
                line1.position.y = UIScreen.mainScreen().bounds.height / 1.5
                
                let line2 = StoryLabelNode(text: NSLocalizedString("Level1.6", comment: ""))
                line2.position.x = UIScreen.mainScreen().bounds.width / 2
                line2.position.y = UIScreen.mainScreen().bounds.height / 1.7
                
                self.addChild(line1)
                self.addChild(line2)
                
            }
            break
            
        case 2:
            if tile.number == 1 {
                
                let line1 = StoryLabelNode(text: NSLocalizedString("Level2.3", comment: ""))
                line1.position.x = UIScreen.mainScreen().bounds.width / 2
                line1.position.y = UIScreen.mainScreen().bounds.height / 1.3
                
                self.addChild(line1)

            }
            else if tile.number == 2 {
                
                let line1 = StoryLabelNode(text: NSLocalizedString("Level2.4", comment: ""))
                line1.position.x = UIScreen.mainScreen().bounds.width / 2
                line1.position.y = UIScreen.mainScreen().bounds.height / 1.2
                
                let line2 = StoryLabelNode(text: NSLocalizedString("Level2.5", comment: ""))
                line2.position.x = UIScreen.mainScreen().bounds.width / 2
                line2.position.y = UIScreen.mainScreen().bounds.height / 1.3
                
                self.addChild(line1)
                self.addChild(line2)
                
            }
            break
        case 3:
            if tile.number == 1 {
                
                let line1 = StoryLabelNode(text: NSLocalizedString("Level3.3", comment: ""))
                line1.position.x = UIScreen.mainScreen().bounds.width / 2
                line1.position.y = UIScreen.mainScreen().bounds.height / 1.2
                self.addChild(line1)
            }
            else if tile.number == 2 {
                
                let line2 = StoryLabelNode(text: NSLocalizedString("Level3.4", comment: ""))
                line2.position.x = UIScreen.mainScreen().bounds.width / 2
                line2.position.y = UIScreen.mainScreen().bounds.height / 1.3
                self.addChild(line2)
            }
            break

        default:
            break

        }
    }

}
