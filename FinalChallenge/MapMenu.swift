//
//  MapMenu.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class MapMenu: SKScene, UIGestureRecognizerDelegate {
    
    var parentScene: SKScene!
    var background: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        
        // Background
        
        background = SKSpriteNode(imageNamed: "desert")
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        background.size = CGSizeMake(self.size.width * 1.5, self.size.height * 1.5)
        background.zPosition = -1
        
        addChild(background)
        
        // PanGesture
        
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("dragMap:"))
        panGesture.delegate = self
        self.view?.addGestureRecognizer(panGesture)
        
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
            else if node.zPosition == 1 {
                let scene = GenericGameScene(size: self.frame.size)
                scene.levelIndex = Int(node.name!)!
                let transition = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
    
    func dragMap(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translationInView(self.view)
        var newXPosition: CGFloat = background.position.x + translation.x
        
        if translation.x > 0 {
            newXPosition = min(newXPosition , 0)
        }
        else if translation.x < 0 {
            newXPosition = max(newXPosition , self.size.width - background.size.width)
        }
        
        background.position.x = newXPosition
        gesture.setTranslation(CGPointZero, inView: self.view)
    }
    
    func addSamLevels() {
        
        let level1 = LevelButton(type: LevelButtonType.Sam)
        level1.position = CGPointMake(60, 100)
        level1.name = "1"
        background.addChild(level1)
        
        let level2 = LevelButton(type: LevelButtonType.Sam)
        level2.position = CGPointMake(90, 190)
        level2.name = "2"
        background.addChild(level2)
        
        let level3 = LevelButton(type: LevelButtonType.Sam)
        level3.position = CGPointMake(150, 150)
        level3.name = "3"
        background.addChild(level3)
        
        let level4 = LevelButton(type: LevelButtonType.Sam)
        level4.position = CGPointMake(210, 110)
        level4.name = "4"
        background.addChild(level4)
        
        let level5 = LevelButton(type: LevelButtonType.Sam)
        level5.position = CGPointMake(270, 140)
        level5.name = "5"
        background.addChild(level5)
        
        let level6 = LevelButton(type: LevelButtonType.Sam)
        level6.position = CGPointMake(320, 200)
        level6.name = "6"
        background.addChild(level6)
    }
    
    func addShrinkLevels() {
        
        let level7 = LevelButton(type: LevelButtonType.Shrink)
        level7.position = CGPointMake(370, 230)
        level7.name = "7"
        background.addChild(level7)
        
        let level8 = LevelButton(type: LevelButtonType.Shrink)
        level8.position = CGPointMake(420, 250)
        level8.name = "8"
        background.addChild(level8)
        
        let level9 = LevelButton(type: LevelButtonType.Shrink)
        level9.position = CGPointMake(470, 270)
        level9.name = "9"
        background.addChild(level9)
        
        let level10 = LevelButton(type: LevelButtonType.Shrink)
        level10.position = CGPointMake(520, 300)
        level10.name = "10"
        background.addChild(level10)
        
        let level11 = LevelButton(type: LevelButtonType.Shrink)
        level11.position = CGPointMake(570, 270)
        level11.name = "11"
        background.addChild(level11)
        
        let level12 = LevelButton(type: LevelButtonType.Shrink)
        level12.position = CGPointMake(620, 230)
        level12.name = "12"
        background.addChild(level12)
    }
    
    func addEllieLevels() {
        
        let level13 = LevelButton(type: LevelButtonType.Ellie)
        level13.position = CGPointMake(370, 190)
        level13.name = "13"
        background.addChild(level13)
        
        let level14 = LevelButton(type: LevelButtonType.Ellie)
        level14.position = CGPointMake(420, 170)
        level14.name = "14"
        background.addChild(level14)
        
        let level15 = LevelButton(type: LevelButtonType.Ellie)
        level15.position = CGPointMake(470, 150)
        level15.name = "15"
        background.addChild(level15)
        
        let level16 = LevelButton(type: LevelButtonType.Ellie)
        level16.position = CGPointMake(520, 130)
        level16.name = "16"
        background.addChild(level16)
        
        let level17 = LevelButton(type: LevelButtonType.Ellie)
        level17.position = CGPointMake(570, 120)
        level17.name = "17"
        background.addChild(level17)
        
        let level18 = LevelButton(type: LevelButtonType.Ellie)
        level18.position = CGPointMake(620, 140)
        level18.name = "18"
        background.addChild(level18)
    }
}