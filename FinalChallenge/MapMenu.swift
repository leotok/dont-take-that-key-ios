//
//  MapMenu.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class MapMenu: SKScene {
    
    var parentScene: SKScene!
    
    override func didMoveToView(view: SKView) {
     
        self.backgroundColor = SKColor.whiteColor()
        
        // Back Button
        
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.anchorPoint = CGPointMake(-1, 1)
        backButton.position = CGPointMake(0, 375)
        backButton.size = CGSize(width: 40, height: 40)
        backButton.name = "back"
     
        addChild(backButton)
    }
 
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "back" {
                
                let transition = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(parentScene, transition: transition)
                
            }
        }
    }
}