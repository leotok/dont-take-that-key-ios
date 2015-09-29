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
     
        self.backgroundColor = SKColor.blackColor()
        
        // Back Button
        
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.position = CGPointMake(30, 380)
        backButton.size = CGSize(width: 40, height: 40)
        backButton.name = "back"
     
        addChild(backButton)
        
        // Level Nodes
        
        let level1 = SKSpriteNode(imageNamed: "clock")
        level1.position = CGPointMake(60, 100)
        level1.size = CGSize(width: 40, height: 40)
        level1.name = "level1"
        
        addChild(level1)
        
        let level2 = SKSpriteNode(imageNamed: "clock")
        level2.position = CGPointMake(90, 180)
        level2.size = CGSize(width: 40, height: 40)
        level2.name = "level2"
        
        addChild(level2)
        
        let level3 = SKSpriteNode(imageNamed: "clock")
        level3.position = CGPointMake(150, 150)
        level3.size = CGSize(width: 40, height: 40)
        level3.name = "level3"
        
        addChild(level3)
        
        let level4 = SKSpriteNode(imageNamed: "clock")
        level4.position = CGPointMake(200, 100)
        level4.size = CGSize(width: 40, height: 40)
        level4.name = "level4"
        
        addChild(level4)
        
        let level5 = SKSpriteNode(imageNamed: "clock")
        level5.position = CGPointMake(420, 140)
        level5.size = CGSize(width: 40, height: 40)
        level5.name = "level5"
        
        addChild(level5)
        
        let level6 = SKSpriteNode(imageNamed: "clock")
        level6.position = CGPointMake(500, 200)
        level6.size = CGSize(width: 40, height: 40)
        level6.name = "level6"
        
        addChild(level6)
        
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