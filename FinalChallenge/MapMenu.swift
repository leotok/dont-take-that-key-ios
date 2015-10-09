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
    var userInfo: UserInfo!
    
    override func didMoveToView(view: SKView) {
        
        // User info
        
        userInfo = DAOUserInfo().load()
        
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
        backButton.size = CGSize(width: 40, height: 40)
        backButton.position = CGPointMake(backButton.size.width/2, (scene?.size.height)! - backButton.size.height/2)
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
            else if node.name == "LevelButton" {
                if (node as! LevelButton).type != LevelButtonType.Locked {
                let levelButton = node as! LevelButton
                let scene = GenericGameScene.createScene(self.size, levelIndex: levelButton.level)
                let transition = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(scene, transition: transition)
                }
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
        
        let level1 = LevelButton(type: LevelButtonType.Sam, level: 1)
        level1.position = CGPointMake(60, 100)
        background.addChild(level1)
        
        let level2 = LevelButton(type: LevelButtonType.Sam, level: 2)
        level2.position = CGPointMake(90, 190)
        background.addChild(level2)
        
        let level3 = LevelButton(type: LevelButtonType.Sam, level: 3)
        level3.position = CGPointMake(150, 150)
        background.addChild(level3)
        
        let level4 = LevelButton(type: LevelButtonType.Sam, level:4)
        level4.position = CGPointMake(210, 110)
        background.addChild(level4)
        
        let level5 = LevelButton(type: LevelButtonType.Sam, level:5)
        level5.position = CGPointMake(270, 140)
        background.addChild(level5)
        
        let level6 = LevelButton(type: LevelButtonType.Sam, level:6)
        level6.position = CGPointMake(320, 200)
        background.addChild(level6)
    }
    
    func addShrinkLevels() {
        
        let level7 = LevelButton(type: LevelButtonType.Locked,level:7)
        level7.position = CGPointMake(370, 230)
        background.addChild(level7)
        
        let level8 = LevelButton(type: LevelButtonType.Locked,level:8)
        level8.position = CGPointMake(420, 250)
        background.addChild(level8)
        
        let level9 = LevelButton(type: LevelButtonType.Locked,level:9)
        level9.position = CGPointMake(470, 270)
        background.addChild(level9)
        
        let level10 = LevelButton(type: LevelButtonType.Locked,level:10)
        level10.position = CGPointMake(520, 300)
        background.addChild(level10)
        
        let level11 = LevelButton(type: LevelButtonType.Locked,level:11)
        level11.position = CGPointMake(570, 270)
        background.addChild(level11)
        
        let level12 = LevelButton(type: LevelButtonType.Locked,level:12)
        level12.position = CGPointMake(620, 230)
        background.addChild(level12)
    }
    
    func addEllieLevels() {
        
        let level13 = LevelButton(type: LevelButtonType.Locked,level:13)
        level13.position = CGPointMake(370, 190)
        background.addChild(level13)
        
        let level14 = LevelButton(type: LevelButtonType.Locked,level:14)
        level14.position = CGPointMake(420, 170)
        background.addChild(level14)
        
        let level15 = LevelButton(type: LevelButtonType.Locked,level:15)
        level15.position = CGPointMake(470, 150)
        background.addChild(level15)
        
        let level16 = LevelButton(type: LevelButtonType.Locked,level:16)
        level16.position = CGPointMake(520, 130)
        background.addChild(level16)
        
        let level17 = LevelButton(type: LevelButtonType.Locked,level:17)
        level17.position = CGPointMake(570, 120)
        background.addChild(level17)
        
        let level18 = LevelButton(type: LevelButtonType.Locked,level:18)
        level18.position = CGPointMake(620, 140)
        background.addChild(level18)
    }
}