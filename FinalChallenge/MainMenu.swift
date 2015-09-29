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
        
        let background = SKSpriteNode(imageNamed: "backgound_teste.jpg")
        background.position = CGPointMake( self.size.width / 2 , self.size.height / 2 )
        background.size = self.size
        
        self.addChild(background)
        
        let playButton = SKLabelNode(fontNamed:"Chalkduster")
        playButton.text = NSLocalizedString("Play", comment: "")
        playButton.fontSize = 45
        playButton.position = CGPointMake(self.size.width / 2, self.size.height / 3.31)
        playButton.name = "Play"
        
        self.addChild(playButton)
        
       let configuration = SKSpriteNode(imageNamed: "configuracao")
        configuration.position = CGPointMake(self.size.width / 1.05, self.size.height / 1.10)
        configuration.size = CGSize(width: 40, height: 40)
        configuration.name = "conf"
        
        self.addChild(configuration)
        
        let gameName = SKLabelNode(fontNamed: "Chalkduster")
        gameName.text = NSLocalizedString("Game Name", comment: "")
        gameName.fontSize = 55
        gameName.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(gameName) 

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "Play" {
                
                let scene = MapMenu(size:self.frame.size)
                let transition = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(scene, transition: transition)
                
            } else if node.name == "conf" {
                
                let scene = Settings(size:self.frame.size)
                let transition2 = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(scene, transition: transition2)
                
            }
        }
    }
}