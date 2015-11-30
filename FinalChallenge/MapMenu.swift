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
        let texture = SKTexture(imageNamed: "map")
        texture.filteringMode = .Nearest
        background = SKSpriteNode(texture: texture)
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        background.size = CGSizeMake(self.size.width * 2, self.size.height)
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
        inAppButotn.position = CGPointMake(size.width - backButton.size.width, (scene?.size.height)! - backButton.size.height/1.5)
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
            
            //      NAO REMOVER COMENTARIO
            // serve para descobrir onde posicionar as fases
            //let xm = background.size.width/location.x
            //let ym = background.size.height/location.y
            //print("CGPointMake(background.size.width / \(xm), background.size.height / \(ym))")
            
            
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
                let inAppScene = InAppMenu(size:self.frame.size)
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
        let samLevelPositionArray = [CGPointMake(self.size.width / 8.1176479695991, self.size.height / 2.40697674418605),
            CGPointMake(self.size.width / 5.41176409869877, self.size.height / 3.47899159663866),
            CGPointMake(self.size.width / 3.00408163265306, self.size.height / 3.72972947337317),
            CGPointMake(self.size.width / 2.3096235046905, self.size.height / 2.35227252333619),
            CGPointMake(self.size.width / 1.93175853018373, self.size.height / 1.72739901887056),
            CGPointMake(self.size.width / 1.5343989206575, self.size.height / 2.04612824364548)]
        
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
        let shrinkLevelPositionArray = [CGPointMake(background.size.width / 2.59307151576196, background.size.height / 1.52392643743134),
            CGPointMake(background.size.width / 2.16258602349113, background.size.height / 1.48564598724679),
            CGPointMake(background.size.width / 1.94280696751388, background.size.height / 1.44924159186388),
            CGPointMake(background.size.width / 1.78640803163518, background.size.height / 1.49099645318319),
            CGPointMake(background.size.width / 1.64469296175216, background.size.height / 1.48387113005073),
            CGPointMake(background.size.width / 1.52591575199344, background.size.height / 1.48387113005073)]
        
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
        let ellieLevelPositionArray = [CGPointMake(background.size.width / 2.81453187721872, background.size.height / 3.64222784261606),
            CGPointMake(background.size.width / 2.27043708924241, background.size.height / 4.85156235541217),
            CGPointMake(background.size.width / 2.02012820063938, background.size.height / 4.85156235541217),
            CGPointMake(background.size.width / 1.87994906097444, background.size.height / 4.92857142857143),
            CGPointMake(background.size.width / 1.75726232173082, background.size.height / 4.92857142857143),
            CGPointMake(background.size.width / 1.64714666209165, background.size.height / 4.92857142857143)]
        
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