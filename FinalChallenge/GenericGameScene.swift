//
//  GameScene.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 24/09/15.
//  Copyright (c) 2015 Hjlmt. All rights reserved.
//

import SpriteKit

class GenericGameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = NSLocalizedString("HelloWorld", comment: "");
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
