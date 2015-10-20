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
        
        let background = SKSpriteNode(imageNamed: "bg_teste")
        background.position = CGPointMake( self.size.width / 2 , self.size.height / 2 )
        background.size = self.size
        self.backgroundColor = UIColor.blackColor()
        self.addChild(background)
        
        let playButton = SKLabelNode(fontNamed:"Pixel-Art")
        playButton.text = NSLocalizedString("Play", comment: "")
        playButton.fontSize = 35
        playButton.position = CGPointMake(self.size.width / 2, self.size.height / 6.1)
        playButton.name = "Play"
        playButton.zPosition = 10
        playButton.runAction(SKAction.repeatActionForever(
            SKAction.sequence([SKAction.fadeOutWithDuration(2),SKAction.fadeInWithDuration(2)])))
        self.addChild(playButton)
        
        let configuration = SKSpriteNode(imageNamed: "configuracaoBt")
        configuration.position = CGPointMake(self.size.width / 1.05, self.size.height / 1.10)
        configuration.size = CGSize(width: 40, height: 40)
        configuration.name = "conf"
        configuration.zPosition = 10
        
        self.addChild(configuration)
        
        let gameName = SKLabelNode(fontNamed: "Pixel-Art")
        gameName.text = NSLocalizedString("Game Name", comment: "")
        gameName.fontSize = 45
        gameName.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height / 2.2)
        gameName.zPosition = 20
        
        self.addChild(gameName)
        
        let relogin = SKSpriteNode(imageNamed: "Relogio")
        relogin.position = CGPointMake(relogin.size.width/2+20, self.size.height-relogin.size.height/2)
        relogin.zPosition = 6
        self.addChild(relogin)
        
        let maiorPonteiro = SKSpriteNode(imageNamed: "Maior")
        maiorPonteiro.zPosition = 7
        maiorPonteiro.anchorPoint = CGPointMake(0.5, 0)
        relogin.addChild(maiorPonteiro)
        
        let menorPonteiro = SKSpriteNode(imageNamed: "Menor")
        menorPonteiro.zPosition = 8
        menorPonteiro.anchorPoint = CGPointMake(0.5, 0)
        relogin.addChild(menorPonteiro)
        
        let meiota = SKSpriteNode(imageNamed: "Meio")
        meiota.zPosition = 9
        relogin.addChild(meiota)
        
        
        let rotateAction = SKAction.rotateByAngle(-36, duration: 10)
        let rotateAction2 = SKAction.rotateByAngle(-36, duration: 20)
        
        maiorPonteiro.runAction(SKAction.repeatActionForever(rotateAction))
        menorPonteiro.runAction(SKAction.repeatActionForever(rotateAction2))
        
        
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
        print(touches.count)
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