//
//  InAppMenu.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 12/11/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class InAppMenu: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.grayColor()
        
        // InApp Purchase Button
        
        let purchaseButton = SKLabelNode(fontNamed:"Pixel-Art")
        purchaseButton.text = NSLocalizedString("inAppLabel", comment: "")
        purchaseButton.fontSize = 15
        purchaseButton.position = CGPointMake(self.size.width / 2, self.size.height / 6.1)
        purchaseButton.name = "purchaseButton"
        purchaseButton.zPosition = ZPositionEnum.Button.rawValue
        self.addChild(purchaseButton)
        
        
        // Blinking Sam
        
        let texture1 = SKTexture(imageNamed: "l0_Iddle_coffee_1")
        let texture2 = SKTexture(imageNamed: "l0_Iddle_coffee_2")
        texture1.filteringMode = SKTextureFilteringMode.Nearest
        texture2.filteringMode = SKTextureFilteringMode.Nearest
        let idleTextures = [texture1,texture2]
        let image = SKSpriteNode(texture: texture1)
        image.position = CGPointMake(size.width / 2, size.height / 2)
        image.xScale = 2
        image.yScale = 2
        
        let wait = SKAction.waitForDuration(1)
        let animate = SKAction.animateWithTextures([idleTextures[1],idleTextures[0]], timePerFrame: 0.1)
        image.runAction(SKAction.repeatActionForever(SKAction.sequence([wait,animate,animate,animate,animate])), withKey:"Idle")
        
        addChild(image)
        
        
        // Back Button
        
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.size = CGSize(width: 40, height: 40)
        backButton.position = CGPointMake(backButton.size.width/2, (scene?.size.height)! - backButton.size.height/2)
        backButton.name = "back"
        
        addChild(backButton)
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "back" {
                
                let scene = MapMenu(size:self.frame.size)
                let transition = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(scene, transition: transition)
            }
            else if node.name == "purchaseButton" {
                
                print("DIÑERO")
            }
            
        }
    }
}