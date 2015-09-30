//
//  HUD.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class HUD: SKSpriteNode {
    
    //var switchCharacterButton: SwitchCharacterButton
    //var pauseButton: PauseButton
    var switchCharacterButton: SKSpriteNode
    var pauseButton: SKSpriteNode
    var leftButton: LeftButton
    var rightButton: RightButton
    var jumpButton: JumpButton
    var powerButton: PowerButton
    
    init() {
//        self.switchCharacterButton = SwitchCharacterButton(characterImage: "Elie")
//        self.pauseButton = PauseButton(pauseImage: "Pause")
        self.leftButton = LeftButton(leftImage: "Left")
        self.rightButton = RightButton(rightImage: "Right")
        self.jumpButton = JumpButton(jumpImage: "Jump")
        self.powerButton = PowerButton(powerImage: "Power")
        self.switchCharacterButton = SKSpriteNode(imageNamed: "Elie")
        self.pauseButton = SKSpriteNode(imageNamed: "Pause")
        
        super.init(texture: nil, color: UIColor.clearColor(), size: UIScreen.mainScreen().bounds.size)
        
    }

    func setPositions(){
        
        self.leftButton = LeftButton(leftImage: "Left")
        self.rightButton = RightButton(rightImage: "Right")
        self.jumpButton = JumpButton(jumpImage: "Jump")
        self.powerButton = PowerButton(powerImage: "Power")
        self.switchCharacterButton = SKSpriteNode(imageNamed: "Elie")
        self.pauseButton = SKSpriteNode(imageNamed: "Pause")
        self.switchCharacterButton.position = CGPointMake(10, (self.scene?.size.height)!-10)
        self.pauseButton.position = CGPointMake((self.scene?.size.width)!-10, (self.scene?.size.height)!-10)
        self.leftButton.position = CGPointMake(10, 10)
        self.rightButton.position = CGPointMake(20, 10)
        self.jumpButton.position = CGPointMake((self.scene?.size.width)!-20, 10)
        self.powerButton.position = CGPointMake((self.scene?.size.width)!-10, 10)
        
        self.switchCharacterButton.zPosition = 2000
        self.pauseButton.zPosition = 2000
        self.leftButton.zPosition = 2000
        self.rightButton.zPosition = 2000
        self.jumpButton.zPosition = 2000
        self.powerButton.zPosition = 2000
        
        self.switchCharacterButton.hidden = false
        self.pauseButton.hidden = false
        self.leftButton.hidden = false
        self.rightButton.hidden = false
        self.jumpButton.hidden = false
        self.powerButton.hidden = false
        
        self.addChild(switchCharacterButton)
        self.addChild(pauseButton)
        self.addChild(leftButton)
        self.addChild(rightButton)
        self.addChild(jumpButton)
        self.addChild(powerButton)
        
        print(self.frame.height)
        print(self.frame.width)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in (touches) {
            let location = touch.locationInNode(self)
            
            if(self.switchCharacterButton.frame.contains(location)){
                self.switchCharacterButton.touchesBegan(touches, withEvent: event)
            }
            else if(self.pauseButton.frame.contains(location)){
                self.pauseButton.touchesBegan(touches, withEvent: event)
            }
            else if(self.leftButton.frame.contains(location)){
                self.leftButton.touchesBegan(touches, withEvent: event)
            }
            else if(self.rightButton.frame.contains(location)){
                self.rightButton.touchesBegan(touches, withEvent: event)
            }
            else if(self.jumpButton.frame.contains(location)){
                self.jumpButton.touchesBegan(touches, withEvent: event)
            }
            else if(self.powerButton.frame.contains(location)){
                self.powerButton.touchesBegan(touches, withEvent: event)
            }
        }
    }
}
