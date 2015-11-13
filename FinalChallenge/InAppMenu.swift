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
        
        //        self.removeAllChildren()
        let purchaseButton = SKLabelNode(fontNamed:"Pixel-Art")
        purchaseButton.text = NSLocalizedString("inAppLabel", comment: "")
        purchaseButton.fontSize = 25
        purchaseButton.position = CGPointMake(self.size.width / 2, self.size.height / 6.1)
        purchaseButton.name = "purchaseButton"
        purchaseButton.zPosition = ZPositionEnum.Button.rawValue
        //        self.addChild(purchaseButton)
        
        
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
                
                let scene = MainMenu(size:self.frame.size)
                let transition = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(scene, transition: transition)
            }
            
        }
    }
}