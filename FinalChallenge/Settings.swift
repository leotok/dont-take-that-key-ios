//
//  Setting.swift
//  FinalChallenge2
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class Settings: SKScene {
    
    var userInfo = UserInfo()
    
    
    override func didMoveToView(view: SKView) {
        // Back Button
        
        let background = SKSpriteNode(imageNamed: "wallpaper1")
        background.position = CGPointMake( self.size.width / 2 , self.size.height / 2 )
        background.size = self.size
        background.alpha = 1
     
        addChild(background)
        
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.position = CGPointMake(30, 380)
        backButton.size = CGSize(width: 40, height: 40)
        backButton.name = "back"
        backButton.zPosition = 10
        
        addChild(backButton)
        
        let musicButton = SKLabelNode(fontNamed: "Chalkduster")
        musicButton.text = NSLocalizedString("music", comment: "")
        musicButton.position = CGPointMake(self.size.width/2, self.size.height/1.38)
        musicButton.name = "music"
        musicButton.zPosition = 10
        musicButton.fontColor = SKColor.blackColor()
        musicButton.color = SKColor.redColor()
        
        addChild(musicButton)
        
        var imgName:String
        if userInfo.musicON == true {
           imgName = "checkbox1"
        }
        else {
            imgName = "checkbox0"
        }
            
        let checkMusicButton = SKSpriteNode(imageNamed: imgName)
        checkMusicButton.size = CGSize(width: 20, height: 20)
        checkMusicButton.position = CGPointMake(self.size.width/1.5, musicButton.position.y + checkMusicButton.size.height/2)
        checkMusicButton.name = "checkMusic"
        checkMusicButton.zPosition = 10
        
        addChild(checkMusicButton)

        print(musicButton.position.y)
        print (checkMusicButton.position.y)
        
        let soundButton = SKLabelNode(fontNamed: "Chalkduster")
        soundButton.text = NSLocalizedString("sound", comment: "")
        soundButton.position = CGPointMake(self.size.width/2, self.size.height/1.66)
        soundButton.name = "sound"
        soundButton.zPosition = 10
        soundButton.fontColor = SKColor.blackColor()
        
        addChild(soundButton)
        
        if userInfo.soundON == true {
        imgName = "checkbox1"
        } else {
        imgName = "checkbox0"
        }
        
        let checkSoundButton = SKSpriteNode(imageNamed: imgName)
        checkSoundButton.size = CGSize(width: 20, height: 20)
        checkSoundButton.position = CGPointMake(self.size.width/1.5, soundButton.position.y + checkSoundButton.size.height/2)
        checkSoundButton.name = "checkSound"
        checkSoundButton.zPosition = 10
        
        addChild(checkSoundButton)

        let languageButton = SKLabelNode(fontNamed: "Chalkduster")
        languageButton.text = NSLocalizedString("language", comment: "")
        languageButton.position = CGPointMake(self.size.width/2, self.size.height/2.08)
        languageButton.name = "language"
        languageButton.zPosition = 10
        languageButton.fontColor = SKColor.blackColor()
        
        addChild(languageButton)
        
        let brazilFlag = SKSpriteNode(imageNamed: "flag_brazil2")
        brazilFlag.position = CGPointMake(self.size.width / 1.45, self.size.height / 2)
        brazilFlag.size = CGSize(width: 30, height: 20)
        brazilFlag.name = "brFlag"
        brazilFlag.zPosition = 10
        
        addChild(brazilFlag)
        
        let euaFlag = SKSpriteNode(imageNamed: "flag_eua2")
        euaFlag.position = CGPointMake(self.size.width / 1.33, self.size.height / 2)
        euaFlag.size = CGSize(width: 30, height: 20)
        euaFlag.name = "enFlag"
        euaFlag.zPosition = 10
        
        addChild(euaFlag)
        
        
        let creditsButton = SKLabelNode(fontNamed: "Chalkduster")
        creditsButton.text = NSLocalizedString("credits", comment: "")
        creditsButton.position = CGPointMake(self.size.width/2, self.size.height/2.76)
        creditsButton.name = "credits"
        creditsButton.zPosition = 10
        creditsButton.fontColor = SKColor.blackColor()
        
        addChild(creditsButton)
        
        let resetButton = SKLabelNode(fontNamed: "Chalkduster")
        resetButton.text = NSLocalizedString("reset game", comment: "")
        resetButton.position = CGPointMake(self.size.width/2, self.size.height/4.14)
        resetButton.name = "reset"
        resetButton.zPosition = 10
        resetButton.fontColor = SKColor.blackColor()
        
        
        addChild(resetButton)

    }
    
    func resetPopUp() {
    
        let popUp = SKSpriteNode(color: SKColor.redColor(), size: CGSizeMake(frame.width*0.6, frame.height*0.6))
        popUp.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        popUp.zPosition = 20
        self.addChild(popUp)
    
        let question = SKLabelNode(text: NSLocalizedString("ResetMsg", comment: ""))
        question.position.y = popUp.size.height*0.19
        popUp.addChild(question)
        
        let yesSquare = SKSpriteNode(color: SKColor.whiteColor(), size: CGSizeMake(frame.width*0.2, frame.height*0.12))
        yesSquare.position = CGPointMake(-0.13*frame.width, -0.14*frame.height)
        popUp.addChild(yesSquare)
        
        let yes = SKLabelNode(text: NSLocalizedString("LeftAnswer", comment: ""))
       //yes.position = CGPointMake(-100, -69)
        yes.fontColor = SKColor.blackColor()
        yesSquare.addChild(yes)
        
        let cancelSquare = SKSpriteNode(color: SKColor.whiteColor(), size: CGSizeMake(frame.width*0.2, frame.height*0.12))
        cancelSquare.position = CGPointMake(0.13*frame.width, -0.14*frame.height)
        popUp.addChild(cancelSquare)
        
        let cancel = SKLabelNode(text: NSLocalizedString("RightAnswer", comment: ""))
       // cancel.position = CGPointMake(100, -69)
        cancel.fontColor = SKColor.blackColor()
        cancelSquare.addChild(cancel)

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "back" {
                
                let scene = MainMenu(size:self.frame.size)
                let transition = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(scene, transition: transition)
                
            }
            else if node.name == "checkMusic" {
            
                let checkBoxMusic = node as! SKSpriteNode
     
                if userInfo.musicON == true {
                
                    checkBoxMusic.texture = SKTexture(imageNamed: "checkbox0")
                    userInfo.musicON = false
                    
                } else {
                
                    checkBoxMusic.texture = SKTexture(imageNamed: "checkbox1")
                    userInfo.musicON = true
                }
            
            }
         
            else if node.name == "checkSound" {
                
                let checkBoxSound = node as! SKSpriteNode
                
                if userInfo.soundON == true {
                    
                    checkBoxSound.texture = SKTexture(imageNamed: "checkbox0")
                    userInfo.soundON = false
                    
                } else {
                    
                    checkBoxSound.texture = SKTexture(imageNamed: "checkbox1")
                    userInfo.soundON = true
                }
                
            } else if node.name == "reset" {
            
            self.resetPopUp()
            
            }
                
            else if node.name == "brFlag" {
                NSUserDefaults.standardUserDefaults().setObject(["pt"], forKey: "AppleLanguages")
                NSUserDefaults.standardUserDefaults().synchronize()
            }

            else if node.name == "enFlag" {
                NSUserDefaults.standardUserDefaults().setObject(["en"], forKey: "AppleLanguages")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
}