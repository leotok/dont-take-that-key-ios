//
//  Credits.swift
//  FinalChallenge
//
//  Created by Mayara Gasparini Dias  on 17/11/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class Credits: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.blackColor()
    
        let credits = SKLabelNode(fontNamed: "Avenir")
        credits.text = NSLocalizedString("Credits", comment: "")
        credits.fontSize = 50
        credits.position = CGPointMake(self.size.width/2, self.size.height/1.25)
        credits.zPosition = ZPositionEnum.Button.rawValue
        credits.fontColor = SKColor.whiteColor()
    
        addChild(credits)
        
        let hugo = SKLabelNode(fontNamed: "Avenir")
        hugo.text = NSLocalizedString("Hugo", comment: "")
        hugo.fontSize = 25
        hugo.position = CGPointMake(self.size.width/2, self.size.height/1.47)
        hugo.zPosition = ZPositionEnum.Button.rawValue
        hugo.fontColor = SKColor.whiteColor()
        
        addChild(hugo)
        
        let leo = SKLabelNode(fontNamed: "Avenir")
        leo.text = NSLocalizedString("Leo", comment: "")
        leo.fontSize = 25
        leo.position = CGPointMake(self.size.width/2, self.size.height/1.72)
        leo.zPosition = ZPositionEnum.Button.rawValue
        leo.fontColor = SKColor.whiteColor()
        
        addChild(leo)
        
        let thiago = SKLabelNode(fontNamed: "Avenir")
        thiago.text = NSLocalizedString("Thiago", comment: "")
        thiago.fontSize = 25
        thiago.position = CGPointMake(self.size.width/2, self.size.height/2.07)
        thiago.zPosition = ZPositionEnum.Button.rawValue
        thiago.fontColor = SKColor.whiteColor()
        
        addChild(thiago)

        let julia = SKLabelNode(fontNamed: "Avenir")
        julia.text = NSLocalizedString("Julia", comment: "")
        julia.fontSize = 25
        julia.position = CGPointMake(self.size.width/2, self.size.height/2.58)
        julia.zPosition = ZPositionEnum.Button.rawValue
        julia.fontColor = SKColor.whiteColor()
        
        addChild(julia)

        let mayara = SKLabelNode(fontNamed: "Avenir")
        mayara.text = NSLocalizedString("Mayara", comment: "")
        mayara.fontSize = 25
        mayara.position = CGPointMake(self.size.width/2, self.size.height/3.45)
        mayara.zPosition = ZPositionEnum.Button.rawValue
        mayara.fontColor = SKColor.whiteColor()
        
        addChild(mayara)
        
        let backButton = SKSpriteNode(imageNamed: "seta")
        backButton.size = CGSize(width: 40, height: 40)
        backButton.position = CGPointMake(30, 380)
        backButton.name = "backButton"
        backButton.zPosition = ZPositionEnum.Button.rawValue
        
        addChild(backButton)
    
    }
    
        
     override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
        if node.name == "backButton" {
            let scene = Settings(size:self.frame.size)
            let transition = SKTransition.fadeWithDuration(0.8)
            self.view?.presentScene(scene, transition: transition)
            
            }
        }
    }
    
} //End of Class