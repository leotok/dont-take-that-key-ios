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
    
    var switchCharacterButton: SwitchCharacterButton?
    var pauseButton: PauseButton?
    var leftButton: LeftButton?
    var rightButton: RightButton?
    
    var jumpButton: JumpButton?
    var powerButton: PowerButton?
    
    
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
        
        scene.physicsWorld.gravity = CGVectorMake(0, -9.8)
        
        return scene
        
    }
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self
        
        self.leftButton = LeftButton()
        self.rightButton = RightButton()
        self.jumpButton = JumpButton()
        self.powerButton = PowerButton(powerImage: "Power")
        self.switchCharacterButton = SwitchCharacterButton(characterImage: "bla")
        self.pauseButton = PauseButton()
        
        let screenWidth = self.scene!.size.width
        let screenHeight = self.scene!.size.height
        
        switchCharacterButton!.position = CGPointMake(switchCharacterButton!.size.width/2, screenHeight - switchCharacterButton!.size.height/2)
        pauseButton!.position = CGPointMake(screenWidth - pauseButton!.size.width/2, screenHeight - pauseButton!.size.height/2)
        leftButton!.position = CGPointMake(leftButton!.frame.size.width/2+10, leftButton!.frame.size.height/2)
        
        rightButton!.position.y = leftButton!.position.y
        rightButton!.position.x = leftButton!.position.x + rightButton!.size.width
        
        jumpButton!.position = CGPointMake(screenWidth - 2 * jumpButton!.size.width, leftButton!.position.y)
        powerButton!.position = CGPointMake(screenWidth - powerButton!.size.width, leftButton!.position.y)
        
        self.switchCharacterButton!.zPosition = 200
        self.pauseButton!.zPosition = 200
        self.leftButton!.zPosition = 200
        self.rightButton!.zPosition = 200
        self.jumpButton!.zPosition = 200
        self.powerButton!.zPosition = 200
        
        //        self.leftButton!.userInteractionEnabled = true
        //        self.rightButton!.userInteractionEnabled = true
        //        self.jumpButton!.userInteractionEnabled = true
        //        self.powerButton!.userInteractionEnabled = true
        //        self.switchCharacterButton!.userInteractionEnabled = true
        //        self.pauseButton!.userInteractionEnabled = true
        //        self.userInteractionEnabled = true
        
        self.addChild(switchCharacterButton!)
        self.addChild(pauseButton!)
        self.addChild(leftButton!)
        self.addChild(rightButton!)
        self.addChild(jumpButton!)
        self.addChild(powerButton!)
        
        //        hud = HUD()
        //        hud.userInteractionEnabled = true
        //        self.addChild(self.hud)
        //        hud.zPosition = 500
        //        hud.setPositions()
        
        
        
        
        //Sam Teste
        selectedPlayer = Sam()
        selectedPlayer.position = CGPointMake(250, 300)
        self.addChild(selectedPlayer)
        
        characterSingleton = CurrentCharacterSingleton.sharedInstance
        characterSingleton.setCurrentCharacter(selectedPlayer)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let characterSingleton = CurrentCharacterSingleton.sharedInstance
        for touch in (touches) {
            let location = touch.locationInNode(self)
            
            if(self.leftButton!.frame.contains(location)){
                characterSingleton.currentCharacter!.stopWalking()
                //self.leftButton.touchesEnded(touches, withEvent: event)
                //                walking = false
                //                walkingLeft = false
            }
            if(self.rightButton!.frame.contains(location)){
                characterSingleton.currentCharacter!.stopWalking()
                //self.rightButton.touchesEnded(touches, withEvent: event)
                //                walking = false
                //                walkingRight = false
            }
            if(self.jumpButton!.frame.contains(location)){
                if(characterSingleton.currentCharacter!.isJumping == true){
                    characterSingleton.currentCharacter?.removeActionForKey("Jump")
                    characterSingleton.currentCharacter!.stopImpulse()
                }
                //self.jumpButton.touchesEnded(touches, withEvent: event)
            }
        }
        
        //        for touch in (touches ) {
        //            let location = touch.locationInNode(self)
        //            let node = self.nodeAtPoint(location)
        //
        //
        //            if popUpOpened {
        //                popUp?.touchesEnded(touches, withEvent: event)
        //            }
        //            else if node.name == "character"{
        //                self.selectedPlayer = node as! GameCharacter
        //            }
        //            else{
        //                //hud.touchesEnded(touches, withEvent: event)
        //            }
        //        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        print("Touches Began")
        var currC = CurrentCharacterSingleton.sharedInstance
        
        for touch in (touches) {
            
            print("For touches")
            let location = touch.locationInNode(self)
            
            if(self.switchCharacterButton!.frame.contains(location)){
            }
            
            if(self.pauseButton!.frame.contains(location)){
                let genericScene = self.scene as! GenericGameScene
                genericScene.pauseGame()
            }
            
            if(self.leftButton!.frame.contains(location)){
                currC.currentCharacter?.walkLeft()
                //                walking = true
                //                walkingLeft = true
                print("leftButton")
            }
            else if(self.rightButton!.frame.contains(location)) {
                currC.currentCharacter?.walkRight()
                //self.rightButton.touchesBegan(touches, withEvent: event)
                //                walking = true
                //                walkingRight = true
                print("rightButton")
            }
            
            if(self.jumpButton!.frame.contains(location)){
                currC.currentCharacter?.jump()
                //self.jumpButton.touchesBegan(touches, withEvent: event)
                print("jumpButton")
            }
            
            if(self.powerButton!.frame.contains(location)){
            }
        }
        //        if popUpOpened {
        //            popUp?.touchesBegan(touches, withEvent: event)
        //        }
        //        else {
        //            //print("to entrando aqui")
        //            hud.touchesBegan(touches, withEvent: event)
        //        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        //        if(hud.isWalking()){
        //            if(hud.walkingLeft){
        //                self.selectedPlayer.physicsBody!.velocity = CGVectorAdd(-200, 0)
        //                CGVectorAdd
        //            }
        //            else{
        //                self.selectedPlayer.physicsBody!.velocity = CGVectorMake(200, 0)
        //
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
        print("you should be called")
        if !popUpOpened {
            print("and you should have netered here")
            self.popUpOpened = true
            self.scene?.paused = true
            self.popUp = PauseMenu.createPauseMenu(self.size)
            self.popUp?.userInteractionEnabled = true
            popUp!.zPosition = 1000
            self.addChild(popUp!)
        }
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
        
        self.popUp = GameOverMenu.createGameOverMenu(self.size)
        self.scene?.paused = true
        self.popUpOpened = true
        self.popUp!.zPosition = 1000
        self.popUp?.userInteractionEnabled = true
        self.addChild(self.popUp!)
    }
    
    private func GameWin() {
        let dao = DAOUserInfo()
        let userInfo = dao.load()
        
        if levelIndex < 6 && userInfo.samLevels <= levelIndex {
            userInfo.samLevels = levelIndex + 1
        }
        else if levelIndex == 6 && userInfo.ellieLevels == 0 && userInfo.shrinkLevels == 0 {
            userInfo.ellieLevels = levelIndex - 5
            userInfo.shrinkLevels = levelIndex - 5
        }
        else if levelIndex < 12 && userInfo.shrinkLevels <= levelIndex - 6 {
            userInfo.shrinkLevels = levelIndex - 5
        }
        else if levelIndex < 18 && userInfo.ellieLevels <= levelIndex - 12 {
            userInfo.ellieLevels = levelIndex - 11
        }
        dao.save(userInfo)
        
        self.popUpOpened = true
        self.scene?.paused = true
        self.popUp = GameWinMenu.createGameWinMenu(self.size)
        self.popUp!.zPosition = 1000
        self.popUp?.userInteractionEnabled = true
        self.addChild(popUp!)
    }
    
}
