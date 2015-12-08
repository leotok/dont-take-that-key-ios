//
//  MainMenu.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class MainMenu: SKScene {
    
    var backgroundMusic = AVAudioPlayer()
    var userInfo:UserInfo!
    
    override func didMoveToView(view: SKView) {
        
        
        let fadeout = SKAction.fadeOutWithDuration(0)
        let fadein = SKAction.fadeInWithDuration(1)
        
        let background = SKSpriteNode(imageNamed: "MainScreenBG")
        background.position = CGPointMake( self.size.width / 2 , self.size.height / 2 )
        background.size = self.size
        self.backgroundColor = UIColor.blackColor()
        self.addChild(background)
        
        let playButton = SKLabelNode(fontNamed:"Pixel-Art")
        playButton.text = NSLocalizedString("Play", comment: "")
        playButton.fontSize = 35
        playButton.position = CGPointMake(self.size.width / 2, self.size.height / 6.1)
        playButton.name = "Play"
        playButton.zPosition = ZPositionEnum.Button.rawValue
        playButton.runAction(SKAction.repeatActionForever(
            SKAction.sequence([SKAction.fadeOutWithDuration(2),SKAction.fadeInWithDuration(2)])))
        self.addChild(playButton)
        
        let configuration = SKSpriteNode(imageNamed: "configuracaoBt")
        configuration.position = CGPointMake(self.size.width / 1.05, self.size.height / 1.10)
        configuration.size = CGSize(width: 40, height: 40)
        configuration.name = "conf"
        configuration.zPosition = ZPositionEnum.Button.rawValue
        
        self.addChild(configuration)
        
        let gameName = SKSpriteNode(imageNamed: "GameName")
        gameName.size = CGSizeMake (1334/2.3, 199/2.3)
        gameName.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height / 1.3)
        gameName.zPosition = ZPositionEnum.Labels.rawValue
        self.addChild(gameName)
        gameName.runAction(SKAction.sequence([fadeout,fadein]))
    
        let key = SKSpriteNode(imageNamed: "MainScreenKey")
        key.size = CGSizeMake(314/1.6, 178/1.6)
        key.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height / 2.1)
        key.zPosition = ZPositionEnum.Labels.rawValue
        self.addChild(key)
        let action = SKAction.moveBy(CGVectorMake(0, 10), duration: 1)
        key.runAction(SKAction.repeatActionForever((SKAction.sequence([action,action.reversedAction()]))))
        
        playBackGroundMusic()
        
    }
    
    
    func playBackGroundMusic() {
        
        let dao = DAOUserInfo()
        userInfo = dao.load()
        
        if userInfo.musicON == true {
            
            if let musicFile = NSBundle.mainBundle().URLForResource("MainMenuMusic", withExtension: "mp3") {
                do {
                    self.backgroundMusic = try AVAudioPlayer(contentsOfURL: musicFile)
                    backgroundMusic.numberOfLoops = -1
                    backgroundMusic.prepareToPlay()
                    backgroundMusic.play()
                }
                catch {
                    print("AVAudio error.")
                    
                }
            }
            else {
                print("Arquivo de som nao existe.")
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.userInteractionEnabled = true
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "Play" {
                
                let scene = MapMenu(size:self.frame.size)
                let transition = SKTransition.fadeWithDuration(1)
                if userInfo.musicON {
                    backgroundMusic.stop()
                }
                self.view?.presentScene(scene, transition: transition)
                
            } else if node.name == "conf" {
                
                let scene = Settings(size:self.frame.size)
                let transition2 = SKTransition.fadeWithDuration(1)
                if userInfo.musicON {
                    backgroundMusic.stop()
                }
                self.view?.presentScene(scene, transition: transition2)
                
            }
        }
    }
}