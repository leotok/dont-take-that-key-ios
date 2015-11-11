//
//  PauseMenu.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class PauseMenu: Menu {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
    }

    
    class func createPauseMenu(size:CGSize)->PauseMenu {

        
        let pauseMenu = PauseMenu(color: UIColor(red: 53/255, green: 42/255, blue: 42/255, alpha: 1), size: CGSizeMake(size.width*0.8, size.height*0.8))
        pauseMenu.position = CGPointMake(size.width/2, size.height/2)
        
        let msgLabel = SKLabelNode(text: "Paused")
        msgLabel.fontColor = UIColor.whiteColor()
        msgLabel.fontSize = 40
        msgLabel.fontName = "Arial"
        msgLabel.position = CGPointMake(0, pauseMenu.size.height/4)
        pauseMenu.addChild(msgLabel)
        
        let restartButton = SKSpriteNode(imageNamed: "RestartButton")
        restartButton.name = "reset"
        restartButton.position = CGPointMake(-restartButton.size.width/2-10, -50)
        
        let resumeButton = SKSpriteNode(imageNamed: "ResumeButton")
        resumeButton.name = "resume"
        resumeButton.position = CGPointMake(0 , 0)

        let quit = SKSpriteNode(imageNamed: "QuitButton")
        quit.name = "quit"
        quit.position = CGPointMake(quit.size.width/2+10, -50)
        
        
        pauseMenu.addChild(resumeButton)
        pauseMenu.addChild(restartButton)
        pauseMenu.addChild(quit)
        
        return pauseMenu
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            let scene = node.scene! as! GenericGameScene
            
            if node.name == "resume" {
                scene.resume()
                self.removeFromParent()
                
            }
            else if node.name == "quit" {
                scene.quitLevel()
            }
            else if node.name == "reset" {
                scene.reset()
                
            }
            
            
        }
    
    }
}// end of class