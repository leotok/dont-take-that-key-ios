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
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(MapMenu.dragMap(_:)))
        panGesture.delegate = self
       // self.view?.addGestureRecognizer(panGesture)
        
        // Back Button
        
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.size = CGSize(width: 40, height: 40)
        backButton.position = CGPointMake(backButton.size.width/2, (scene?.size.height)! - backButton.size.height/2)
        backButton.name = "back"
     
        addChild(backButton)
        
        
        /*/ InApp-Purchase Button
        
        let inAppButotn = SKSpriteNode(imageNamed: "inApp")
        inAppButotn.size = CGSize(width: 40, height: 40)
        inAppButotn.position = CGPointMake(size.width - backButton.size.width, (scene?.size.height)! - backButton.size.height/1.5)
        inAppButotn.name = "inApp"
        
        addChild(inAppButotn)
        */
        
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
//             serve para descobrir onde posicionar as fases
//            let xm = background.size.width/location.x
//            let ym = background.size.height/location.y
//            print("CGPointMake(background.size.width / \(xm), background.size.height / \(ym))")
            
            
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
                 


                    let scene = LoadingScene(size:self.size)
                    scene.level = levelButton.level
                    
                    self.removeAllChildren()
                    self.removeAllActions()
                    self.background = nil
                    
                    self.view?.presentScene(scene)
                }
            }
            else if node.name == "inApp" {
                print("inApp")
                self.view?.removeGestureRecognizer(panGesture)
                let inAppScene = InAppMenu(size:self.frame.size)
                let transition = SKTransition.fadeWithDuration(0.5)
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
        let samLevelPositionArray = [CGPointMake(background.size.width / 16.7058823529412, background.size.height / 2.020000),
            CGPointMake(background.size.width / 10.8708149844543, background.size.height / 2.72340478581948),
            CGPointMake(background.size.width / 6.884849758236, background.size.height / 3.31606296268039),
            CGPointMake(background.size.width / 5.10142891689225, background.size.height / 2.72678183540883),
            CGPointMake(background.size.width / 4.61989955584896, background.size.height / 1.92771119776552),
            CGPointMake(background.size.width / 3.85783823351868, background.size.height / 1.5384617641833),
            CGPointMake(background.size.width / 3.0827684888935, background.size.height / 1.78770980199203)]
        
        for i in 1...7 {
            
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
        let shrinkLevelPositionArray = [CGPointMake(background.size.width / 2.5876996764024, background.size.height / 1.38528165979724),
            CGPointMake(background.size.width / 2.17416293339785, background.size.height / 1.35306588830693),
            CGPointMake(background.size.width / 1.88235332192122, background.size.height / 1.48491910892901),
            CGPointMake(background.size.width / 1.70955637123564, background.size.height / 1.57635503526998),
            CGPointMake(background.size.width / 1.55297360160215, background.size.height / 1.69761314435312),
            CGPointMake(background.size.width / 1.46959919714674, background.size.height / 1.85507295604928)]

        
        for i in 1...6 {
            
            let level: LevelButton!
            
            if i <= userInfo.shrinkLevels {
                level = LevelButton(type: LevelButtonType.Locked, level: i + 7)
            }
            else {
                level = LevelButton(type: LevelButtonType.Locked, level: i + 7)
            }
            level.position = shrinkLevelPositionArray[i-1]
            background.addChild(level)
        }
    }
    
    func addEllieLevels() {
        
        let userInfo = DAOUserInfo().load()
        let ellieLevelPositionArray = [CGPointMake(background.size.width / 2.81536597728947, background.size.height / 2.86995613883532),
            CGPointMake(background.size.width / 2.27200027734378, background.size.height / 3.65714381377576),
            CGPointMake(background.size.width / 1.97565259333657, background.size.height / 3.78698293236419),
            CGPointMake(background.size.width / 1.83078180780347, background.size.height / 3.26530739348563),
            CGPointMake(background.size.width / 1.71471713910646, background.size.height / 2.62295131175894),
            CGPointMake(background.size.width / 1.61020580660287, background.size.height / 2.92237504007175)]
        
        for i in 1...6 {
            
            let level: LevelButton!
            
            if i <= userInfo.ellieLevels {
                level = LevelButton(type: LevelButtonType.Locked, level: i + 13)
            }
            else {
                level = LevelButton(type: LevelButtonType.Locked, level: i + 13)
            }
            level.position = ellieLevelPositionArray[i-1]
            background.addChild(level)
        }
    }
}