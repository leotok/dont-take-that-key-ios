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
    var switchCharacterButton: SwitchCharacterButton
    var pauseButton: PauseButton
    var leftButton: LeftButton
    var rightButton: RightButton
    var jumpButton: JumpButton
    var powerButton: PowerButton
    var currentCharacter: GameCharacter?
    var walking: Bool = false
    var walkingLeft: Bool = false
    var walkingRight: Bool = false
    
    init() {

        //self.switchCharacterButton = SwitchCharacterButton(characterImage: "Elie")
        self.leftButton = LeftButton()
        self.rightButton = RightButton()
        self.jumpButton = JumpButton()
        self.powerButton = PowerButton(powerImage: "Power")
        self.switchCharacterButton = SwitchCharacterButton(characterImage: "bla")
        self.pauseButton = PauseButton()
        
        super.init(texture: nil, color: UIColor.clearColor(), size: UIScreen.mainScreen().bounds.size)
        
        //self.position = CGPoint(x: 100,y: 100)
        
//        self.leftButton.userInteractionEnabled = true
//        self.rightButton.userInteractionEnabled = true
//        self.jumpButton.userInteractionEnabled = true
//        self.powerButton.userInteractionEnabled = true
//        self.switchCharacterButton.userInteractionEnabled = true
//        self.pauseButton.userInteractionEnabled = true
//        self.userInteractionEnabled = true
    }

    func setPositions(){

        let screenWidth = self.scene!.size.width
        let screenHeight = self.scene!.size.height
        
        switchCharacterButton.position = CGPointMake(switchCharacterButton.size.width/2, screenHeight - switchCharacterButton.size.height/2)
        pauseButton.position = CGPointMake(screenWidth - pauseButton.size.width/2, screenHeight - pauseButton.size.height/2)
        leftButton.position = CGPointMake(leftButton.frame.size.width/2+10, leftButton.frame.size.height/2)
        
        rightButton.position.y = leftButton.position.y
        rightButton.position.x = leftButton.position.x + rightButton.size.width
        
        jumpButton.position = CGPointMake(screenWidth - 2 * jumpButton.size.width, leftButton.position.y)
        powerButton.position = CGPointMake(screenWidth - powerButton.size.width, leftButton.position.y)
        
        self.switchCharacterButton.zPosition = 2
        self.pauseButton.zPosition = 2
        self.leftButton.zPosition = 2
        self.rightButton.zPosition = 2
        self.jumpButton.zPosition = 2
        self.powerButton.zPosition = 2
        
        self.addChild(switchCharacterButton)
        self.addChild(pauseButton)
        self.addChild(leftButton)
        self.addChild(rightButton)
        self.addChild(jumpButton)
        self.addChild(powerButton)

    }
    
    func setCharacter(currentCharacter: GameCharacter){
        self.currentCharacter = currentCharacter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isWalking()-> Bool{
        return walking
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        let currC = CurrentCharacterSingleton.sharedInstance
        for touch in (touches) {
            let location = touch.locationInNode(self)
            
            if(self.switchCharacterButton.frame.contains(location)){
            }
            if(self.pauseButton.frame.contains(location)){
                let genericScene = self.scene as! GenericGameScene
                genericScene.pauseGame()
            }
            if(self.leftButton.frame.contains(location)){
                currC.currentCharacter?.walkLeft()
                walking = true
                walkingLeft = true
                print("leftButton")
            }
            else if(self.rightButton.frame.contains(location)){
                currC.currentCharacter?.walkRight()
                //self.rightButton.touchesBegan(touches, withEvent: event)
                walking = true
                walkingRight = true
                print("rightButton")
            }
            if(self.jumpButton.frame.contains(location)){
                currC.currentCharacter?.jump()
                //self.jumpButton.touchesBegan(touches, withEvent: event)
                print("jumpButton")
            }
            if(self.powerButton.frame.contains(location)){
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let characterSingleton = CurrentCharacterSingleton.sharedInstance
        for touch in (touches) {
            let location = touch.locationInNode(self)
            
            if(self.leftButton.frame.contains(location)){
                characterSingleton.currentCharacter!.stopWalking()
                //self.leftButton.touchesEnded(touches, withEvent: event)
                walking = false
                walkingLeft = false
            }
            if(self.rightButton.frame.contains(location)){
                characterSingleton.currentCharacter!.stopWalking()
                //self.rightButton.touchesEnded(touches, withEvent: event)
                walking = false
                walkingRight = false
            }
            if(self.jumpButton.frame.contains(location)){
                if(characterSingleton.currentCharacter!.isJumping == true){
                    characterSingleton.currentCharacter?.removeActionForKey("Jump")
                    characterSingleton.currentCharacter!.stopImpulse()
                }
                //self.jumpButton.touchesEnded(touches, withEvent: event)
            }
        }
    }
}
