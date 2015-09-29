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
        
        // Add Levels Nodes
        
        addSamLevels()
        addShrinkLevels()
        addEllieLevels()
        
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
            else {
                let scene = GenericGameScene(size: self.frame.size)
                let transition = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
    
    func addSamLevels() {
        
        let level1 = SKSpriteNode(imageNamed: "clock")
        level1.position = CGPointMake(60, 100)
        level1.size = CGSize(width: 40, height: 40)
        level1.name = "1"
        
        addChild(level1)
        
        let level2 = SKSpriteNode(imageNamed: "clock")
        level2.position = CGPointMake(90, 190)
        level2.size = CGSize(width: 40, height: 40)
        level2.name = "2"
        
        addChild(level2)
        
        let level3 = SKSpriteNode(imageNamed: "clock")
        level3.position = CGPointMake(150, 150)
        level3.size = CGSize(width: 40, height: 40)
        level3.name = "3"
        
        addChild(level3)
        
        let level4 = SKSpriteNode(imageNamed: "clock")
        level4.position = CGPointMake(210, 110)
        level4.size = CGSize(width: 40, height: 40)
        level4.name = "4"
        
        addChild(level4)
        
        let level5 = SKSpriteNode(imageNamed: "clock")
        level5.position = CGPointMake(270, 140)
        level5.size = CGSize(width: 40, height: 40)
        level5.name = "5"
        
        addChild(level5)
        
        let level6 = SKSpriteNode(imageNamed: "clock")
        level6.position = CGPointMake(320, 200)
        level6.size = CGSize(width: 40, height: 40)
        level6.name = "6"
        
        addChild(level6)
    }
    
    func addShrinkLevels() {
        
        let level7 = SKSpriteNode(imageNamed: "freud")
        level7.position = CGPointMake(370, 230)
        level7.size = CGSize(width: 40, height: 40)
        level7.name = "7"
        
        addChild(level7)
        
        let level8 = SKSpriteNode(imageNamed: "freud")
        level8.position = CGPointMake(420, 250)
        level8.size = CGSize(width: 40, height: 40)
        level8.name = "8"
        
        addChild(level8)
        
        let level9 = SKSpriteNode(imageNamed: "freud")
        level9.position = CGPointMake(470, 270)
        level9.size = CGSize(width: 40, height: 40)
        level9.name = "9"
        level10.
        
        addChild(level9)
        
        let level10 = SKSpriteNode(imageNamed: "freud")
        level10.position = CGPointMake(520, 300)
        level10.size = CGSize(width: 40, height: 40)
        level10.name = "10"
        
        addChild(level10)
        
        let level11 = SKSpriteNode(imageNamed: "freud")
        level11.position = CGPointMake(570, 270)
        level11.size = CGSize(width: 40, height: 40)
        level11.name = "11"
        
        addChild(level11)
        
        let level12 = SKSpriteNode(imageNamed: "freud")
        level12.position = CGPointMake(620, 230)
        level12.size = CGSize(width: 40, height: 40)
        level12.name = "12"
        
        addChild(level12)
    }
    
    func addEllieLevels() {
        
        
        let level13 = SKSpriteNode(imageNamed: "fat-bottom-girls")
        level13.position = CGPointMake(370, 190)
        level13.size = CGSize(width: 40, height: 40)
        level13.name = "13"
        
        addChild(level13)
        
        let level14 = SKSpriteNode(imageNamed: "fat-bottom-girls")
        level14.position = CGPointMake(420, 170)
        level14.size = CGSize(width: 40, height: 40)
        level14.name = "14"
        
        addChild(level14)
        
        let level15 = SKSpriteNode(imageNamed: "fat-bottom-girls")
        level15.position = CGPointMake(470, 150)
        level15.size = CGSize(width: 40, height: 40)
        level15.name = "15"
        
        addChild(level15)
        
        let level16 = SKSpriteNode(imageNamed: "fat-bottom-girls")
        level16.position = CGPointMake(520, 130)
        level16.size = CGSize(width: 40, height: 40)
        level16.name = "16"
        
        addChild(level16)
        
        let level17 = SKSpriteNode(imageNamed: "fat-bottom-girls")
        level17.position = CGPointMake(570, 120)
        level17.size = CGSize(width: 40, height: 40)
        level17.name = "17"
        
        addChild(level17)
        
        let level18 = SKSpriteNode(imageNamed: "fat-bottom-girls")
        level18.position = CGPointMake(620, 140)
        level18.size = CGSize(width: 40, height: 40)
        level18.name = "18"
        
        addChild(level18)
        
    }
}