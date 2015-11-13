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
    var panGesture: UIPanGestureRecognizer!
    
    override func didMoveToView(view: SKView) {
        
        // Background
        let texture = SKTexture(imageNamed: "desert")
        background = SKSpriteNode(texture: nil, color: UIColor.blackColor(), size: texture.size())//(imageNamed: "desert")
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        background.size = CGSizeMake(self.size.width * 1.5, self.size.height * 1.5)
        background.zPosition = ZPositionEnum.Background.rawValue
        background.color = UIColor.grayColor()
        addChild(background)
        
        // PanGesture
        
        panGesture = UIPanGestureRecognizer(target: self, action: Selector("dragMap:"))
        panGesture.delegate = self
        self.view?.addGestureRecognizer(panGesture)
        
        // Back Button
        
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.size = CGSize(width: 40, height: 40)
        backButton.position = CGPointMake(backButton.size.width/2, (scene?.size.height)! - backButton.size.height/2)
        backButton.name = "back"
     
        addChild(backButton)
        
        
        // InApp-Purchase Button
        
        let inAppButotn = SKSpriteNode(imageNamed: "inApp")
        inAppButotn.size = CGSize(width: 40, height: 40)
        inAppButotn.position = CGPointMake(size.width - backButton.size.width/2, (scene?.size.height)! - backButton.size.height/2)
        inAppButotn.name = "inApp"
        
        addChild(inAppButotn)
        
        
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
                let transition = SKTransition.fadeWithDuration(1)
                self.view?.removeGestureRecognizer(panGesture)
                self.view?.presentScene(scene, transition: transition)
            }
            else if node.name == "LevelButton" {
                if (node as! LevelButton).type != LevelButtonType.Locked {
                    
                    self.view?.removeGestureRecognizer(panGesture)
                    let levelButton = node as! LevelButton
                    let scene = GenericGameScene.createScene(self.size, levelIndex: levelButton.level)
                    self.view?.presentScene(scene)
                }
            }
            else if node.name == "inApp" {
                print("inApp")
                self.view?.removeGestureRecognizer(panGesture)
                let inAppScene = InAppMenu()
                let transition = SKTransition.fadeWithDuration(1)
                self.view?.presentScene(inAppScene, transition: transition)
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
        
        let userInfo = DAOUserInfo().load()
        let samLevelPositionArray = [CGPointMake(60, 100),CGPointMake(90, 190),CGPointMake(150, 150),CGPointMake(210, 110), CGPointMake(270, 140), CGPointMake(320, 200)]
        
        for i in 1...6 {
            
            let level: LevelButton!
            
            if i <= userInfo.samLevels {
                level = LevelButton(type: LevelButtonType.Sam, level: i)
            }
            else {
                level = LevelButton(type: LevelButtonType.Locked, level: i)
            }
            level.position = samLevelPositionArray[i-1]
            background.addChild(level)
        }
    }
    
    func addShrinkLevels() {
        
        let userInfo = DAOUserInfo().load()
        let shrinkLevelPositionArray = [CGPointMake(370, 230),CGPointMake(420, 250),CGPointMake(470, 270),CGPointMake(520, 300), CGPointMake(570, 270), CGPointMake(620, 230)]
        
        for i in 1...6 {
            
            let level: LevelButton!
            
            if i <= userInfo.shrinkLevels {
                level = LevelButton(type: LevelButtonType.Locked, level: i + 6)
            }
            else {
                level = LevelButton(type: LevelButtonType.Locked, level: i + 6)
            }
            level.position = shrinkLevelPositionArray[i-1]
            background.addChild(level)
        }
    }
    
    func addEllieLevels() {
        
        let userInfo = DAOUserInfo().load()
        let ellieLevelPositionArray = [CGPointMake(370, 190),CGPointMake(420, 170),CGPointMake(470, 150),CGPointMake(520, 130), CGPointMake(570, 120), CGPointMake(620, 140)]
        
        for i in 1...6 {
            
            let level: LevelButton!
            
            if i <= userInfo.ellieLevels {
                level = LevelButton(type: LevelButtonType.Locked, level: i + 12)
            }
            else {
                level = LevelButton(type: LevelButtonType.Locked, level: i + 12)
            }
            level.position = ellieLevelPositionArray[i-1]
            background.addChild(level)
        }
    }
}