//
//  Setting.swift
//  FinalChallenge2
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class Settings: SKScene {
    
    override func didMoveToView(view: SKView) {
        // Back Button
        
        let background = SKSpriteNode(imageNamed: "wallpaper1")
        background.position = CGPointMake( self.size.width / 2 , self.size.height / 2 )
        background.size = self.size
        background.alpha = 0.9
     
        addChild(background)
        
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.position = CGPointMake(30, 380)
        backButton.size = CGSize(width: 40, height: 40)
        backButton.name = "back"
        backButton.zPosition = 10
        
        addChild(backButton)
        
        let musicButton = SKLabelNode(fontNamed: "Chalkduster")
        musicButton.text = NSLocalizedString("music", comment: "")
        musicButton.position = CGPointMake(self.size.width/2, self.size.height/1.38)
        musicButton.name = "music"
        musicButton.zPosition = 10
        
        addChild(musicButton)
        
        let soundButton = SKLabelNode(fontNamed: "Chalkduster")
        soundButton.text = NSLocalizedString("sound", comment: "")
        soundButton.position = CGPointMake(self.size.width/2, self.size.height/1.66)
        soundButton.name = "sound"
        soundButton.zPosition = 10
        
        addChild(soundButton)
        
        let languageButton = SKLabelNode(fontNamed: "Chalkduster")
        languageButton.text = NSLocalizedString("language", comment: "")
        languageButton.position = CGPointMake(self.size.width/2, self.size.height/2.08)
        languageButton.name = "language"
        languageButton.zPosition = 10
        
        addChild(languageButton)
        
        let brazilFlag = SKSpriteNode(imageNamed: "flag_brazil2")
        brazilFlag.position = CGPointMake(self.size.width / 1.45, self.size.height / 2)
        brazilFlag.size = CGSize(width: 30, height: 20)
        brazilFlag.name = "brazilianFlag"
        brazilFlag.zPosition = 10
        
        addChild(brazilFlag)
        
        let euaFlag = SKSpriteNode(imageNamed: "flag_eua2")
        euaFlag.position = CGPointMake(self.size.width / 1.33, self.size.height / 2)
        euaFlag.size = CGSize(width: 30, height: 20)
        euaFlag.name = "euaFlag"
        euaFlag.zPosition = 10
        
        addChild(euaFlag)
        
        
        let creditsButton = SKLabelNode(fontNamed: "Chalkduster")
        creditsButton.text = NSLocalizedString("credits", comment: "")
        creditsButton.position = CGPointMake(self.size.width/2, self.size.height/2.76)
        creditsButton.name = "credits"
        creditsButton.zPosition = 10
        
        addChild(creditsButton)
        
        let resetButton = SKLabelNode(fontNamed: "Chalkduster")
        resetButton.text = NSLocalizedString("reset game", comment: "")
        resetButton.position = CGPointMake(self.size.width/2, self.size.height/4.14)
        resetButton.name = "reset"
        resetButton.zPosition = 10
        
        addChild(resetButton)
        


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