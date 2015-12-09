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
    
    var userInfo:UserInfo!
    var popUp:SKSpriteNode?
    
    override func didMoveToView(view: SKView) {
        
        let dao = DAOUserInfo()
        self.userInfo = dao.load()
        
        let gear1 = SKSpriteNode(imageNamed: "brownGear")
        self.addChild(gear1)
        let rodaRoda = SKAction.rotateByAngle(-30, duration: 20)
        gear1.runAction(SKAction.repeatActionForever(rodaRoda))
        gear1.position = CGPointMake(gear1.size.width/2,gear1.size.height/2)
        gear1.zPosition = 10
        
        let gear2 = SKSpriteNode(imageNamed: "grayGear")
        self.addChild(gear2)
        let rodaRoda2 = SKAction.rotateByAngle(60, duration: 20)
        gear2.runAction(SKAction.repeatActionForever(rodaRoda2))
        gear2.position = CGPointMake(gear2.size.width/2,self.size.height-gear2.size.height/2)
        gear2.zPosition = 10
        gear2.size = CGSizeMake(90, 90)
        
        let gear3 = SKSpriteNode(imageNamed: "gearsBACK")
        self.addChild(gear3)
        let rodaRoda3 = SKAction.rotateByAngle(60, duration: 20)
        gear3.runAction(SKAction.repeatActionForever(rodaRoda3))
        gear3.position = CGPointMake(self.size.width-gear3.size.width/2,self.size.height/2)
        gear3.zPosition = 10
        gear3.size = CGSizeMake(130, 130)

        let gear4 = SKSpriteNode(imageNamed: "bigGear")
        self.addChild(gear4)
        let rodaRoda4 = SKAction.rotateByAngle(-40, duration: 23)
        gear4.runAction(SKAction.repeatActionForever(rodaRoda4))
        gear4.position = CGPointMake(self.size.width/5.66,self.size.height/3)
        gear4.zPosition = 10
       
        let gear5 = SKSpriteNode(imageNamed: "gearsBACK")
        self.addChild(gear5)
        let rodaRoda5 = SKAction.rotateByAngle(60, duration: 20)
        gear5.runAction(SKAction.repeatActionForever(rodaRoda5))
        gear5.position = CGPointMake(self.size.width/4.33,self.size.height/1.38)
        gear5.zPosition = 10
        gear5.size = CGSizeMake(150, 150)
        
        let background = SKSpriteNode(imageNamed: "wallpaper1")
        background.position = CGPointMake( self.size.width / 2 , self.size.height / 2 )
        background.size = self.size
        background.alpha = 1
     
        addChild(background)
        
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.size = CGSize(width: 40, height: 40)
        backButton.position = CGPointMake(25, size.height - 25)
        backButton.name = "back"
        backButton.zPosition = ZPositionEnum.Button.rawValue
        
        addChild(backButton)
        
        let musicButton = SKLabelNode(fontNamed: "Pixel-Art")
        musicButton.text = NSLocalizedString("MusicSettings", comment: "")
        musicButton.position = CGPointMake(self.size.width/2, self.size.height/1.38)
        musicButton.name = "music"
        musicButton.zPosition = ZPositionEnum.Button.rawValue
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
        checkMusicButton.zPosition = ZPositionEnum.Button.rawValue
        
        addChild(checkMusicButton)
        
        let soundButton = SKLabelNode(fontNamed: "Pixel-Art")
        soundButton.text = NSLocalizedString("SoundSettings", comment: "")
        soundButton.position = CGPointMake(self.size.width/2, self.size.height/1.66)
        soundButton.name = "sound"
        soundButton.zPosition = ZPositionEnum.Button.rawValue
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
        checkSoundButton.zPosition = ZPositionEnum.Button.rawValue
        
        addChild(checkSoundButton)

        let languageButton = SKLabelNode(fontNamed: "Pixel-Art")
        languageButton.text = NSLocalizedString("LanguageSettings", comment: "")
        languageButton.position = CGPointMake(self.size.width/2, self.size.height/2.08)
        languageButton.name = "language"
        languageButton.zPosition = ZPositionEnum.Button.rawValue
        languageButton.fontColor = SKColor.blackColor()
        
        addChild(languageButton)
        
        let brazilFlag = SKSpriteNode(imageNamed: "BRAflag")
        brazilFlag.position = CGPointMake(self.size.width / 1.45, self.size.height / 2)
        brazilFlag.size = CGSize(width: 30, height: 20)
        brazilFlag.name = "brFlag"
        brazilFlag.zPosition = ZPositionEnum.Button.rawValue
        
        addChild(brazilFlag)
        
        let euaFlag = SKSpriteNode(imageNamed: "EUAflag2")
        euaFlag.position = CGPointMake(self.size.width / 1.33, self.size.height / 2)
        euaFlag.size = CGSize(width: 30, height: 20)
        euaFlag.name = "enFlag"
        euaFlag.zPosition = ZPositionEnum.Button.rawValue
        
        addChild(euaFlag)
        
        
        let creditsButton = SKLabelNode(fontNamed: "Pixel-Art")
        creditsButton.text = NSLocalizedString("CreditsSettings", comment: "")
        creditsButton.position = CGPointMake(self.size.width/2, self.size.height/2.76)
        creditsButton.name = "credits"
        creditsButton.zPosition = ZPositionEnum.Button.rawValue
        creditsButton.fontColor = SKColor.blackColor()
        
        addChild(creditsButton)
        
        let resetButton = SKLabelNode(fontNamed: "Pixel-Art")
        resetButton.text = NSLocalizedString("ResetGameSettings", comment: "")
        resetButton.position = CGPointMake(self.size.width/2, self.size.height/4.14)
        resetButton.name = "reset"
        resetButton.zPosition = ZPositionEnum.Button.rawValue
        resetButton.fontColor = SKColor.blackColor()
        
        
        addChild(resetButton)

    }
    
    func resetPopUp() {
    
        self.popUp = SKSpriteNode(color: SKColor.redColor(), size: CGSizeMake(frame.width*0.6, frame.height*0.6))
        self.popUp?.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        self.popUp?.zPosition = ZPositionEnum.PopUp.rawValue
        self.addChild(popUp!)
        
        let question = SKLabelNode(text: NSLocalizedString("ResetMsg", comment: ""))
        question.position.y = popUp!.size.height*0.19
        popUp!.addChild(question)
        
        let yesSquare = SKSpriteNode(color: SKColor.whiteColor(), size: CGSizeMake(frame.width*0.2, frame.height*0.12))
        yesSquare.position = CGPointMake(-0.13*frame.width, -0.14*frame.height)
        yesSquare.name = "yesSquare"
        popUp!.addChild(yesSquare)
        
        let yes = SKLabelNode(text: NSLocalizedString("LeftAnswer", comment: ""))
       //yes.position = CGPointMake(-100, -69)
        yes.fontColor = SKColor.blackColor()
        yes.name = "yesSquare"
        yesSquare.addChild(yes)
        
        let cancelSquare = SKSpriteNode(color: SKColor.whiteColor(), size: CGSizeMake(frame.width*0.2, frame.height*0.12))
        cancelSquare.position = CGPointMake(0.13*frame.width, -0.14*frame.height)
        cancelSquare.name = "cancelSquare"
        popUp!.addChild(cancelSquare)
        
        let cancel = SKLabelNode(text: NSLocalizedString("RightAnswer", comment: ""))
       // cancel.position = CGPointMake(100, -69)
        cancel.fontColor = SKColor.blackColor()
        cancel.name = "cancelSquare"
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
                
            } else if node.name == "credits" {
                
                self.removeAllActions()
                self.removeAllChildren()
                let scene = Credits(size:self.frame.size)
                let transition = SKTransition.fadeWithDuration(0.8)
                self.view?.presentScene(scene, transition: transition)
            
            }
            else if node.name == "checkMusic" {
            
                let checkBoxMusic = node as! SKSpriteNode
                
                let dao = DAOUserInfo()
                
                if userInfo.musicON == true {
                
                    checkBoxMusic.texture = SKTexture(imageNamed: "checkbox0")
                    userInfo.musicON = false
                    
                } else {
                
                    checkBoxMusic.texture = SKTexture(imageNamed: "checkbox1")
                    userInfo.musicON = true
                }
            
                dao.save(userInfo)
            }
         
            else if node.name == "checkSound" {
                
                let checkBoxSound = node as! SKSpriteNode
                
                let dao = DAOUserInfo()

                if userInfo.soundON == true {
                    
                    checkBoxSound.texture = SKTexture(imageNamed: "checkbox0")
                    userInfo.soundON = false
                    
                } else {
                    
                    checkBoxSound.texture = SKTexture(imageNamed: "checkbox1")
                    userInfo.soundON = true
                }
                
                dao.save(userInfo)
                
            } else if node.name == "reset" {
            
            self.resetPopUp()
            
            } else if node.name == "cancelSquare" {
                
                self.popUp?.removeFromParent()
            }
            else if node.name == "yesSquare" {
                self.popUp?.removeFromParent()
                self.userInfo = UserInfo()
                DAOUserInfo().save(self.userInfo)
            
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