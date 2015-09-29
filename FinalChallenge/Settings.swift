//
//  Setting.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class Settings: SKScene {
    
    override func didMoveToView(view: SKView) {
        // Back Button
        
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.position = CGPointMake(30, 380)
        backButton.size = CGSize(width: 40, height: 40)
        backButton.name = "back"
        
        addChild(backButton)

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "back" {
                
                let scene = MainMenu(size:self.frame.size)
                let transition = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(scene, transition: transition)
                
            }
        }
    }
}