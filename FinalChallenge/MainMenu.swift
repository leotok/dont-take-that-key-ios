//
//  MainMenu.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {
    
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = SKColor.redColor()
        
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = NSLocalizedString("Play", comment: "");
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        myLabel.name = "Play"
        
        self.addChild(myLabel)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "Play" {
            
                let scene = GenericGameScene(size:self.frame.size)
                let transition = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(scene, transition: transition)
            
            }
            
            
        }
        
        
        
    }
    
    
}