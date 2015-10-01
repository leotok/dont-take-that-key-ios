//
//  PauseMenu.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class PauseMenu: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
    }

    
    class func createPauseMenu(size:CGSize)->PauseMenu {

        
        let pauseMenu = PauseMenu(color: UIColor.redColor(), size: CGSizeMake(size.width*0.8, size.height*0.8))
        pauseMenu.position = CGPointMake(size.width/2, size.height/2)
        let resumeButton = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(150, 50))
        resumeButton.name = "resume"

        let quit = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(150, 50))
        quit.name = "quit"
        
        
        pauseMenu.addChild(resumeButton)
        
        return pauseMenu
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print("asdsda")
    }
    
}