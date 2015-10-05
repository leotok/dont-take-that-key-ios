//
//  GameOverMenu.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverMenu: SKSpriteNode {
 
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
    }
    
    
    class func createGameOverMenu(size:CGSize)->GameOverMenu {
        
        
        let pauseMenu = GameOverMenu(color: UIColor.redColor(), size: CGSizeMake(size.width*0.8, size.height*0.8))
        pauseMenu.position = CGPointMake(size.width/2, size.height/2)
        
        let resumeButton = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(150, 50))
        resumeButton.name = "reset"
        resumeButton.position = CGPointMake(-70, -50)
        
        let quit = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(150, 50))
        quit.name = "quit"
        quit.position = CGPointMake(70, -50)
        
        
        pauseMenu.addChild(resumeButton)
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
            
            if node.name == "reset" {
                scene.reset()
                
            }
            else if node.name == "quit" {
                scene.quitLevel()
            }
            
            
        }
        
    }
}// end of class