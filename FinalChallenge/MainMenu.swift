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
        
        let background = SKSpriteNode(imageNamed: "backgound_teste.jpg")
        background.position = CGPointMake( self.size.width / 2 , self.size.height / 2 )
        background.size = self.size
        
        self.addChild(background)
        
        let playButton = SKLabelNode(fontNamed:"Chalkduster")
        playButton.text = NSLocalizedString("Play", comment: "")
        playButton.fontSize = 45
        playButton.position = CGPointMake(self.size.width / 2, self.size.height / 3.31)
        playButton.name = "Play"
        playButton.zPosition = 10
        
        self.addChild(playButton)
        
       let configuration = SKSpriteNode(imageNamed: "configuracaoBt")
        configuration.position = CGPointMake(self.size.width / 1.05, self.size.height / 1.10)
        configuration.size = CGSize(width: 40, height: 40)
        configuration.name = "conf"
        configuration.zPosition = 10
        
        self.addChild(configuration)
        
        let gameName = SKLabelNode(fontNamed: "Chalkduster")
        gameName.text = NSLocalizedString("Game Name", comment: "")
        gameName.fontSize = 55
        gameName.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        gameName.zPosition = 10
        
        self.addChild(gameName)
        
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
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "Play" {
                
                let scene = MapMenu(size:self.frame.size)
                let transition = SKTransition.fadeWithDuration(1.5)
                if userInfo.musicON {
                    backgroundMusic.stop()
                }
                self.view?.presentScene(scene, transition: transition)
                
            } else if node.name == "conf" {
                
                let scene = Settings(size:self.frame.size)
                let transition2 = SKTransition.fadeWithDuration(1.5)
                if userInfo.musicON {
                    backgroundMusic.stop()
                }
                self.view?.presentScene(scene, transition: transition2)
                
            }
        }
    }
}