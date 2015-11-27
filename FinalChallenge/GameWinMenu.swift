//
//  GameWinMenu.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class GameWinMenu: Menu {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
    }
    
    
    class func createGameWinMenu(size:CGSize)->GameWinMenu {
        
        
        let pauseMenu = GameWinMenu(color: UIColor(red: 53/255, green: 42/255, blue: 42/255, alpha: 1), size: CGSizeMake(size.width*0.8, size.height*0.8))
        pauseMenu.position = CGPointMake(size.width/2, size.height/2)
        
        let msgLabel = SKLabelNode(text: "You Won!")
        msgLabel.fontColor = UIColor.whiteColor()
        msgLabel.fontSize = 40
        msgLabel.fontName = "Arial"
        msgLabel.position = CGPointMake(0, pauseMenu.size.height/4)
        pauseMenu.addChild(msgLabel)
        
        let quit = SKSpriteNode(imageNamed: "QuitButton")
        quit.name = "quit"
        quit.position = CGPointMake(quit.size.width/2+10, -50)
        
        let image = UIImage(named: "NextButton")
        let texture = SKTexture(image: image!)
        texture.filteringMode = .Nearest
        texture.size().height
        let resumeButton = SKSpriteNode(texture: texture)
        resumeButton.size = CGSize(width: 2*texture.size().width, height: 2*texture.size().height)
        resumeButton.name = "next"
        resumeButton.position = CGPointMake(-resumeButton.size.width/2-10, -50)
        
        pauseMenu.addChild(resumeButton)
        pauseMenu.addChild(quit)
        
        return pauseMenu
    }
    
    func imageResize (imageObj:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            let scene = node.scene! as! GenericGameScene
            
            if node.name == "next" {
                scene.quitLevel()
            }
            else if node.name == "quit" {
                scene.quitLevel()
            }
            
            
        }
        
    }
    
} // End of Class