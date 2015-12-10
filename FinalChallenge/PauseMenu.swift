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

        let texture = SKTexture(imageNamed: "PopUp_preto")
        texture.filteringMode = .Nearest
        let pauseMenu = PauseMenu(texture: texture, color: SKColor.clearColor(), size: CGSizeMake(size.width * 0.8, size.height * 0.8))
        pauseMenu.position = CGPointMake(size.width/2, size.height/2.5)
        
        let msgLabel = SKLabelNode(text: "Paused")
        msgLabel.fontColor = UIColor.whiteColor()
        msgLabel.fontSize = 38
        msgLabel.fontName = "Pixel-Art"
        msgLabel.position = CGPointMake(0, pauseMenu.size.height / 6.5)
        msgLabel.zPosition = ZPositionEnum.Labels.rawValue

        let restartLabel = SKLabelNode(text: "RESTART")
        restartLabel.name = "reset"
        restartLabel.fontColor = UIColor.whiteColor()
        restartLabel.fontSize = 24
        restartLabel.fontName = "Pixel-Art"
        restartLabel.position = CGPointMake(0, -pauseMenu.size.height / 7)
        restartLabel.zPosition = ZPositionEnum.Labels.rawValue


        let resumeLabel = SKLabelNode(text: "RESUME")
        resumeLabel.name = "resume"
        resumeLabel.fontColor = UIColor.whiteColor()
        resumeLabel.fontSize = 24
        resumeLabel.fontName = "Pixel-Art"
        resumeLabel.position = CGPointMake(0, 0)
        resumeLabel.zPosition = ZPositionEnum.Labels.rawValue


        let textQuit = SKTexture(imageNamed: "QuitButton")
        textQuit.filteringMode = .Nearest
        let quit = SKSpriteNode(texture: textQuit, color: SKColor.clearColor(), size: CGSizeMake(textQuit.size().width / 2, textQuit.size().height / 2 ))
        quit.name = "quit"
        quit.position = CGPointMake(0,  -pauseMenu.size.height / 4 )
        quit.zPosition = ZPositionEnum.Labels.rawValue
        
//        let gear1 = SKSpriteNode(imageNamed: "bigGear")
//        pauseMenu.addChild(gear1)
//        let rodaRoda1 = SKAction.rotateByAngle(60, duration: 20)
//        gear1.runAction(SKAction.repeatActionForever(rodaRoda1))
//        gear1.position = CGPointMake(-pauseMenu.size.height/1.35,pauseMenu.size.height / 2.5)
//        gear1.zPosition = ZPositionEnum.Labels.rawValue
//        gear1.size = CGSizeMake(90, 90)
//        
//        let gear2 = SKSpriteNode(imageNamed: "bigGear")
//        pauseMenu.addChild(gear2)
//        let rodaRoda2 = SKAction.rotateByAngle(60, duration: 20)
//        gear2.runAction(SKAction.repeatActionForever(rodaRoda2))
//        gear2.position = CGPointMake(-pauseMenu.size.height/1.35,pauseMenu.size.height / 2.5)
//        gear2.zPosition = ZPositionEnum.Labels.rawValue
//        gear2.size = CGSizeMake(90, 90)
        
        pauseMenu.addChild(msgLabel)
        pauseMenu.addChild(restartLabel)
        pauseMenu.addChild(resumeLabel)
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