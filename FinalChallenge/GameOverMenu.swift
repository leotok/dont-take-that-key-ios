//
//  GameOverMenu.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverMenu: Menu {
 
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
    }
    
    
    class func createGameOverMenu(size:CGSize)-> GameOverMenu {
        
        
        
        let texture = SKTexture(imageNamed: "PopUp_preto")
        texture.filteringMode = .Nearest
        let menu = GameOverMenu(texture: texture, color: SKColor.clearColor(), size: CGSizeMake(size.width * 0.8, size.height * 0.8))
        menu.position = CGPointMake(size.width/2, size.height/2.5)
        
        let msgLabel = SKLabelNode(text: "Try again")
        msgLabel.fontColor = UIColor.whiteColor()
        msgLabel.fontSize = 38
        msgLabel.fontName = "Pixel-Art"
        msgLabel.position = CGPointMake(0, menu.size.height / 6.5)
        msgLabel.zPosition = ZPositionEnum.Labels.rawValue
        
        let restartLabel = SKLabelNode(text: "RESTART")
        restartLabel.name = "reset"
        restartLabel.fontColor = UIColor.whiteColor()
        restartLabel.fontSize = 24
        restartLabel.fontName = "Pixel-Art"
        restartLabel.position = CGPointMake(0, -menu.size.height / 16 )
        restartLabel.zPosition = ZPositionEnum.Labels.rawValue
        
        let textQuit = SKTexture(imageNamed: "QuitButton")
        textQuit.filteringMode = .Nearest
        let quit = SKSpriteNode(texture: textQuit, color: SKColor.clearColor(), size: CGSizeMake(textQuit.size().width / 2, textQuit.size().height / 2 ))
        quit.name = "quit"
        quit.position = CGPointMake(0,  -menu.size.height / 5.5 )
        quit.zPosition = ZPositionEnum.Labels.rawValue
    
        menu.addChild(msgLabel)
        menu.addChild(restartLabel)
        menu.addChild(quit)
        
        return menu

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