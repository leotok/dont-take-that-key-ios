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
    
    let switchCharacterButton: SwitchCharacterButton
    let pauseButton: PauseButton
    let leftButton: LeftButton
    let rightButton: RightButton
    let jumpButton: JumpButton
    let powerButton: PowerButton
    var currentCharacter: GameCharacter?
    var walking: Bool = false
    var walkingLeft: Bool = false
    var walkingRight: Bool = false
    
    init() {
        self.leftButton = LeftButton()
        self.rightButton = RightButton()
        self.jumpButton = JumpButton()
        self.powerButton = PowerButton(powerImage: "Power")
        self.switchCharacterButton = SwitchCharacterButton(characterImage: "bla")
        self.pauseButton = PauseButton()
        
        super.init(texture: nil, color: UIColor.clearColor(), size: UIScreen.mainScreen().bounds.size)

        self.zPosition = ZPositionEnum.Button.rawValue
    }

    func setPositions(){
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        switchCharacterButton.position = CGPointMake(switchCharacterButton.size.width/2, screenHeight - switchCharacterButton.size.height/2)
        pauseButton.position = CGPointMake(screenWidth  /*- pauseButton.size.width/2*/ , screenHeight - pauseButton.size.height/2)
        leftButton.position = CGPointMake(leftButton.frame.size.width/2+10, leftButton.frame.size.height/2+7)
        
        rightButton.position.y = leftButton.position.y
        rightButton.position.x = leftButton.position.x + rightButton.size.width + 10
        
        jumpButton.position = CGPointMake(screenWidth - /* 2 * */ jumpButton.size.width - 20, leftButton.position.y)
        powerButton.position = CGPointMake(jumpButton.position.x + powerButton.size.width + 10, leftButton.position.y)
        
        self.switchCharacterButton.zPosition = ZPositionEnum.Button.rawValue
        self.pauseButton.zPosition = ZPositionEnum.Button.rawValue
        self.leftButton.zPosition = ZPositionEnum.Button.rawValue
        self.rightButton.zPosition = ZPositionEnum.Button.rawValue
        self.jumpButton.zPosition = ZPositionEnum.Button.rawValue
        self.powerButton.zPosition = ZPositionEnum.Button.rawValue
        
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
                walking = true
                walkingRight = true
                print("rightButton")
            }
            if(self.jumpButton.frame.contains(location)){
                currC.currentCharacter?.jump()
                print("jumpButton")
            }
            if(self.powerButton.frame.contains(location)){
                currC.currentCharacter?.usePower()
                switchCharacterButton.changeSwitchButtonImage()
            
            }
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        print("cancelled was called")
        let characterSingleton = CurrentCharacterSingleton.sharedInstance
        for touch in (touches)! {
            let location = touch.locationInNode(self)
            
            if(self.leftButton.frame.contains(location)){
                characterSingleton.currentCharacter!.stopWalking()
                walking = false
                walkingLeft = false
            }
            if(self.rightButton.frame.contains(location)){
                characterSingleton.currentCharacter!.stopWalking()
                walking = false
                walkingRight = false
            }
            if(self.jumpButton.frame.contains(location)){
                if(characterSingleton.currentCharacter!.isJumping == true){
                    characterSingleton.currentCharacter?.removeActionForKey("Jump")
                    characterSingleton.currentCharacter!.stopImpulse()
                }
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        let characterSingleton = CurrentCharacterSingleton.sharedInstance
        for touch in (touches) {
            let previousLocation = touch.previousLocationInNode(self)
            let location = touch.locationInNode(self)
            
            if(self.leftButton.frame.contains(previousLocation) && !self.leftButton.frame.contains(location)){
                characterSingleton.currentCharacter!.stopWalking()
                walking = false
                walkingLeft = false
            }
            if(self.rightButton.frame.contains(previousLocation) && !self.rightButton.frame.contains(location)){
                characterSingleton.currentCharacter!.stopWalking()
                walking = false
                walkingRight = false
            }
            if(self.jumpButton.frame.contains(previousLocation) && !self.jumpButton.frame.contains(location)){
                if(characterSingleton.currentCharacter!.isJumping == true){
                    characterSingleton.currentCharacter?.removeActionForKey("Jump")
                    characterSingleton.currentCharacter!.stopImpulse()
                }
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let characterSingleton = CurrentCharacterSingleton.sharedInstance
        for touch in (touches) {
            let location = touch.locationInNode(self)
            
            if(self.leftButton.frame.contains(location)){
                characterSingleton.currentCharacter!.stopWalking()
                walking = false
                walkingLeft = false
            }
            if(self.rightButton.frame.contains(location)){
                characterSingleton.currentCharacter!.stopWalking()
                walking = false
                walkingRight = false
            }
            if(self.jumpButton.frame.contains(location)){
                if(characterSingleton.currentCharacter!.isJumping == true){
                    characterSingleton.currentCharacter?.removeActionForKey("Jump")
                    characterSingleton.currentCharacter!.stopImpulse()
                }
            }
        }
    }
}
