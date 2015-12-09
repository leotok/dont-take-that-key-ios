//
//  LoadingScene.swift
//  Dont take that Key
//
//  Created by Leonardo Edelman Wajnsztok on 04/12/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import SpriteKit

class LoadingScene: SKScene {

    var level:Int!
    var msg:SKLabelNode!
    var gameScene:GenericGameScene!
    
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = SKColor.blackColor()
        self.msg = SKLabelNode(text: "Loading")
        self.msg.fontName = "Pixel-Art"
        
        self.msg.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        let act1 = SKAction.runBlock({
            self.msg.text = "Loading."
        })
        let act2 = SKAction.runBlock({
            self.msg.text = "Loading.."
        })
        let act3 = SKAction.runBlock({
            self.msg.text = "Loading..."
        })
        let act4 = SKAction.runBlock({
            self.msg.text = "Loading"
        })
        let wait = SKAction.waitForDuration(0.1)
        
        let sequence = SKAction.sequence([wait,act1,wait,act2,wait,act3,wait,act4,wait])
        self.runAction(SKAction.repeatActionForever(sequence), withKey:"Animate")

        
        msg.position.y = self.frame.size.height/2
        msg.position.x = self.frame.size.width/2 - msg.frame.size.width/2
        self.addChild(msg)
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        
        /* Carregar a fase em background */
        dispatch_async(backgroundQueue, {
            print("This is run on the background queue")
            self.gameScene = GenericGameScene.createScene(self.size, levelIndex: self.level)

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                let transition = SKTransition.fadeWithDuration(1)
                self.removeActionForKey("Animate")
                self.msg = nil
                self.view?.presentScene(self.gameScene ,transition: transition)
            })
            })
        
    }
    
    
}//End of Class
