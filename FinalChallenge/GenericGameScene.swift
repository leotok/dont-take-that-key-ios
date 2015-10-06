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
    var selectedPlayer: GameCharacter!
    var characters:[Character]!
    var gameLayer:SKNode!
    var pausableLayer:SKNode!
    var characterSingleton:CurrentCharacterSingleton!
    var popUpOpened = false
    var popUp:Menu?
    
    
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
        
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self
        
        hud = HUD()
        self.addChild(self.hud)
        hud.zPosition = 500
        hud.setPositions()
        

        

        //Sam Teste
        selectedPlayer = Sam()
        selectedPlayer.setWalkingTextures([SKTexture(imageNamed: "Sam_Walk1"),
                                           SKTexture(imageNamed: "Sam_Walk2"),
                                           SKTexture(imageNamed: "Sam_Walk3"),
                                           SKTexture(imageNamed: "Sam_Walk4")])
        selectedPlayer.position = CGPointMake(300, 300)
        self.addChild(selectedPlayer)
        
        characterSingleton = CurrentCharacterSingleton.sharedInstance
        characterSingleton.setCurrentCharacter(selectedPlayer)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            
            if popUpOpened {
                popUp?.touchesEnded(touches, withEvent: event)
            }
            else if node.name == "character"{
                self.selectedPlayer = node as! GameCharacter
            }
            else{
                hud.touchesEnded(touches, withEvent: event)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        if popUpOpened {
            popUp?.touchesBegan(touches, withEvent: event)
        }
        else {
            hud.touchesBegan(touches, withEvent: event)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
//        self.selectedPlayer.physicsBody!.velocity = CGVectorMake(-200, 0)
//        
//        if(hud.isWalking()){
//            if(hud.walkingLeft){
//                self.selectedPlayer.physicsBody!.velocity = CGVectorMake(-200, 0)
//            }
//            else{
//                self.selectedPlayer.physicsBody!.velocity = CGVectorMake(200, 0)
//            }
//        }
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var playerPB:SKPhysicsBody
        var notPlayerPB:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            playerPB = contact.bodyA
            notPlayerPB = contact.bodyB
        }
        else {
            playerPB = contact.bodyB
            notPlayerPB = contact.bodyA
        }
        
        let player = playerPB.node as! GameCharacter
        
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
            if(playerPB.node?.position.y > notPlayerPB.node?.position.y){
                selectedPlayer.reachedGround()
            }
        }
        
    }
    
    
    override func didSimulatePhysics() {
        //centerCamera()
    }
    func centerCamera() {
        let positionInScene = self.convertPoint(selectedPlayer.position, fromNode: selectedPlayer.parent!)
        self.position = CGPointMake(gameLayer.position.x - positionInScene.x + 200, gameLayer.position.y)
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
    
    func quitLevel() {
    
        let scene = MapMenu(size:self.size)
        let transition = SKTransition.fadeWithDuration(1.5)
        self.view?.presentScene(scene, transition: transition)
    }
    
    //Menus
    func pauseGame() {
        self.popUpOpened = true
        self.scene?.paused = true
        self.popUp = PauseMenu.createPauseMenu(self.size)
        popUp!.zPosition = 1000
        self.addChild(popUp!)
    }
    func resume() {
        self.scene?.paused = false
        self.popUpOpened = false
    
    }
    func reset() {
        let scene = GenericGameScene.createScene(self.size, levelIndex: levelIndex)
        let transition = SKTransition.fadeWithDuration(1.5)
        self.view?.presentScene(scene, transition: transition)
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
