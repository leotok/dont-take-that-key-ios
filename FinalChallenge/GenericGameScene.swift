//
//  GameScene.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 24/09/15.
//  Copyright (c) 2015 Hjlmt. All rights reserved.
//

import SpriteKit


let playerCategory:UInt32 = 1
let objectCategory:UInt32 = 2
let hazardCategory:UInt32 = 4
let keyCategory:UInt32 = 8
let doorCategory:UInt32 = 16

class GenericGameScene: SKScene, Pausable, SKPhysicsContactDelegate {
    
    var levelIndex = 0
    var hud:HUD!
    var selectedPlayer:Character!
    var characters:[Character]!
    var gameLayer:SKNode!
    var pausableLayer:SKNode!
    var characterSingleton:CurrentCharacterSingleton!
    
    private var gotKey = false

    
    override private init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func createScene (size:CGSize, levelIndex:Int)->GenericGameScene {
        
        let scene = GenericGameScene(size: size)
        scene.levelIndex = levelIndex
        let lvlGen = LevelGenerator()
        
        scene.gameLayer = SKNode()
        scene.gameLayer.zPosition = 50
        scene.addChild(scene.gameLayer)
        
        scene.pausableLayer = SKNode()
        scene.gameLayer.addChild(scene.pausableLayer)
    
        
        lvlGen.loadLevel(levelIndex, scene: scene)

        return scene
    
    }
    
    
    
    //to remove
    func lixosDoLeo() {
        // Back Button
        
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.position = CGPointMake(30, 380)
        backButton.size = CGSize(width: 40, height: 40)
        backButton.name = "back"
        
        addChild(backButton)
        
        let levelTitle = SKLabelNode(fontNamed:"Chalkduster")
        levelTitle.text = "Fase \(levelIndex)"
        levelTitle.fontSize = 45
        levelTitle.position = CGPointMake(self.size.width / 2, self.size.height / 3.31)
        levelTitle.zPosition = 10
        addChild(levelTitle)
    
    }
    
    override func didMoveToView(view: SKView) {
        //to remove
        self.lixosDoLeo()
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self
        
        hud = HUD()
        self.addChild(self.hud)
        hud.zPosition = 500
        hud.setPositions()
        

        

        //Sam Teste
        selectedPlayer = Sam()
        selectedPlayer.position = CGPointMake(300, 300)
        self.addChild(selectedPlayer)
        
        characterSingleton = CurrentCharacterSingleton.sharedInstance
        characterSingleton.setCurrentCharacter(selectedPlayer)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "back" {
                
                let scene = MapMenu(size:self.frame.size)
                let transition = SKTransition.fadeWithDuration(1.5)
                self.view?.presentScene(scene, transition: transition)
                
            }
            else{
                hud.touchesEnded(touches, withEvent: event)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        hud.touchesBegan(touches, withEvent: event)
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    

    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var playerPB:SKPhysicsBody
        var notPlayerPB:SKPhysicsBody
        
        print("firstContact")
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            playerPB = contact.bodyA
            notPlayerPB = contact.bodyB
        }
        else {
            playerPB = contact.bodyB
            notPlayerPB = contact.bodyA
        }
        
        let player = playerPB.node as! Character
        
        if notPlayerPB.categoryBitMask == hazardCategory {
            player.die()
            self.GameOver()
            
        }
        else if notPlayerPB.categoryBitMask == keyCategory {
            gotKey = true
            notPlayerPB.node?.removeFromParent()
        }
        else if notPlayerPB.categoryBitMask == doorCategory {
            if gotKey {
                self.GameWin()
            }
        }
        else if notPlayerPB.categoryBitMask == objectCategory {
            print("ay que la hora")
            if(playerPB.node?.position.y > notPlayerPB.node?.position.y){
                selectedPlayer.reachedGround()
            }
        }
        
    }
    
    
    // Sam Protocol
    func pauseScene() -> Bool {
        pausableLayer.paused = true
        return true
    }
    func unpauseScene() -> Bool {
        pausableLayer.paused = false
        return false
    }
    
    //Menus
    private func pauseGame() {
    
        self.scene?.paused = true
        let menu = PauseMenu()
        menu.zPosition = 1000
        self.addChild(menu)
    }
    
    private func GameOver() {
        
        let menu = GameOverMenu()
        menu.zPosition = 1000
        self.addChild(menu)
    }
    
    private func GameWin() {
        
        let menu = GameWinMenu()
        menu.zPosition = 1000
        self.addChild(menu)
    }
    
}
