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
let keyCategory:UInt32    = 8
let doorCategory:UInt32   = 16
let controlTileCategory: UInt32 = 32
let clockHandCategory: UInt32 = 64
let crateCategory: UInt32 = 128
let clockBlockCategory: UInt32 = 256

enum ZPositionEnum : CGFloat {
    
    case Background     = -1
    case GameLayer      = 1
    case Objects        = 3
    case Spike          = 2
    case ClockHand      = 4
    case Tile           = 6
    case NegBackground  = 8
    case Button         = 10
    case Labels         = 12
    case Character      = 14
    case PopUp          = 16

}

class GenericGameScene: SKScene, Pausable, SKPhysicsContactDelegate {
    
    var levelIndex = 0
    var levelStory: StoryText!
    var hud:HUD!
    var selectedPlayer: GameCharacter!
    var characters:[Character]!
    var gameLayer:SKNode!
    var pausableLayer:SKNode!
    var characterSingleton:CurrentCharacterSingleton!
    var popUpOpened = false
    var popUp:Menu?
    var finishedPositioning: Bool = false
    
    var pausableObjectsArray = [SKSpriteNode]()
    
    var lastPositionX: CGFloat?
    var lastPositionY: CGFloat?
    var onBeginAchiev:String?
    var onWinAchiev:String?
    
    
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
        scene.gameLayer.zPosition = ZPositionEnum.GameLayer.rawValue
        scene.addChild(scene.gameLayer)
        
        scene.pausableLayer = SKNode()
        scene.pausableLayer.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeZero)
        scene.pausableLayer.physicsBody?.collisionBitMask = 0
        scene.gameLayer.addChild(scene.pausableLayer)
        
        scene.shouldEnableEffects = true
        
        lvlGen.loadLevel(levelIndex, scene: scene)
    
        scene.size = lvlGen.getLevelSize()
        
        if(scene.size.width-UIScreen.mainScreen().bounds.size.width > 200){
            let cameraNode = SKCameraNode()
            scene.camera = cameraNode
            scene.camera?.position = CGPointMake(50,300)
            scene.addChild(cameraNode)
        }
        
        scene.physicsWorld.gravity = CGVectorMake(0, -9.8)
        
        
        
        return scene
        
    }
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        let scene1 = GenericGameScene(size: scene!.size)
        scene1.gameLayer = SKNode()
        scene1.gameLayer.zPosition = ZPositionEnum.GameLayer.rawValue
        scene1.addChild(scene1.gameLayer)
        
        scene1.pausableLayer = SKNode()
        scene1.pausableLayer.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeZero)
        scene1.pausableLayer.physicsBody?.collisionBitMask = 0
        scene1.gameLayer.addChild(scene1.pausableLayer)
        
        self.physicsWorld.contactDelegate = self
        
        hud = HUD()
        self.addChild(self.hud)
        hud.zPosition = ZPositionEnum.Button.rawValue
        hud.setPositions()
        
        
        levelStory = StoryText.getStoryforLevel(self.levelIndex, size: size)
        addChild(levelStory)
        
        self.lastPositionX = selectedPlayer.position.x
        self.lastPositionY = selectedPlayer.position.y
        
        characterSingleton = CurrentCharacterSingleton.sharedInstance
        characterSingleton.setCurrentCharacter(selectedPlayer)
        
        GameCenterManager.sharedInstance.postAchievement("HelloWorld")
        
        ADMobSingleton.sharedIstance.loadInterstitial()

        
        
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
                    finishedPositioning = true
                }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        hud.touchesMoved(touches, withEvent: event)
        
        if let camera = scene?.camera {
            let t = touches.first!
            let lp = t.previousLocationInNode(self)
            let p = t.locationInNode(self)
            let x = lp.x-p.x
            let y = lp.y-p.y
            camera.position.x += x
            camera.position.y += y
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
       // print("\(selectedPlayer.position.x) \(selectedPlayer.position.y)")
        self.centerCamera()
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if self.paused {
            return
        }
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
        
        print("categoria: \(notPlayerPB.categoryBitMask)")
        
        if ((playerPB.node?.isKindOfClass(GameCharacter)) == true ) {
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
            else if notPlayerPB.categoryBitMask == objectCategory || notPlayerPB.categoryBitMask == clockHandCategory || notPlayerPB.categoryBitMask == crateCategory {
//                if playerPB.velocity.dy == 0 {
                if contact.contactNormal.dy > 0 {
    //                if(playerPB.node?.position.y > notPlayerPB.node?.position.y){
                    finishedPositioning = true
                    selectedPlayer.reachedGround()
                }
            }
    //        else if (notPlayerPB.categoryBitMask == clockHandCategory || notPlayerPB.categoryBitMask == crateCategory ){
    //            selectedPlayer.reachedGround()
    //        }
            else if notPlayerPB.categoryBitMask == controlTileCategory {
                
                let control = notPlayerPB.node as! ControlTile
                print(control.activated)
                if control.activated == false {
                    control.activated = true
                    levelStory.reactToControlTile(control, level: levelIndex)
                }   
            }
        }
        else {
            // tratamento objetos nao player
            if notPlayerPB.categoryBitMask == clockBlockCategory || playerPB.categoryBitMask == clockBlockCategory
            {
                notPlayerPB.dynamic = false
            }
        }

    }
    
    func centerCamera() {
        if(self.lastPositionX >= 50 && self.lastPositionX <= 682 && self.camera != nil){
            scene!.camera?.position = CGPointMake(selectedPlayer.position.x+545,selectedPlayer.position.y-141)
            //scene?.camera?.position = selectedPlayer.position
            
            if(finishedPositioning){
                self.hud.position = CGPointMake(self.hud.position.x+(selectedPlayer.position.x-self.lastPositionX!), self.hud.position.y+(selectedPlayer.position.y-self.lastPositionY!))
            }
        }
        
        self.lastPositionX = selectedPlayer.position.x
        self.lastPositionY = selectedPlayer.position.y
        
    }
    
    // Sam Protocol
    func pauseScene() -> Bool {
        
        pausableLayer.paused = true
        
        print(" number of paused objects: \(pausableObjectsArray.count)")
        for(var i = 0;i < pausableObjectsArray.count;i++) {
            //if(!pausableObjectsArray[i].isKindOfClass(CrateNode)){
//                print("caixa \(i + 1) parou!")
                pausableObjectsArray[i].physicsBody?.affectedByGravity = false
                pausableObjectsArray[i].paused = true
                pausableObjectsArray[i].physicsBody?.dynamic = false
                pausableObjectsArray[i].physicsBody?.velocity = CGVectorMake(0, 0)
            //}

        }
        return true
    }
    func unpauseScene() -> Bool {
        pausableLayer.paused = false
        
        for(var i = 0;i < pausableObjectsArray.count;i++) {
            if(pausableObjectsArray[i].isKindOfClass(CrateNode) || pausableObjectsArray[i].isKindOfClass(ClockHandBlockNode) || pausableObjectsArray[i].isKindOfClass(AmpulhetaNode)){
                pausableObjectsArray[i].physicsBody?.affectedByGravity = true
                pausableObjectsArray[i].physicsBody?.dynamic = true
            }

                pausableObjectsArray[i].paused = false
            
            
        }
        return false
    }
    
    func quitLevel() {
        
        shouldShowAd()
        cleanScene()
        
        let scene = MapMenu(size:self.size)
        let transition = SKTransition.fadeWithDuration(1)
        self.view?.presentScene(scene, transition: transition)
    }
    
    private func cleanScene() {
        
        self.paused = true
        self.removeAllChildren()
        self.removeAllActions()
        self.pausableLayer.removeAllChildren()
        self.characterSingleton.currentCharacter = nil  // ???
        self.pausableObjectsArray.removeAll()
        self.characters = nil
        self.selectedPlayer = nil
        self.hud = nil
        self.popUp = nil
        self.scene?.removeFromParent()
        self.removeFromParent()

    }
    
    func shouldShowAd() {
        
        ADMobSingleton.sharedIstance.adCounter++
        
        if ADMobSingleton.sharedIstance.adCounter > 2 {
            
            ADMobSingleton.sharedIstance.adCounter = 0
            //NSNotificationCenter.defaultCenter().postNotificationName("ShowAd", object: nil)
        }

    }
    
    // Menus
    func pauseGame() {
        if !popUpOpened {
            self.popUpOpened = true
            self.scene?.paused = true
            self.popUp = PauseMenu.createPauseMenu(UIScreen.mainScreen().bounds.size)
            self.popUp?.position = CGPointMake(size.width / 2, size.height / 2)//CGPointMake(selectedPlayer.position.x+200,selectedPlayer.position.y+25)
            self.popUp?.userInteractionEnabled = true
            popUp!.zPosition = ZPositionEnum.PopUp.rawValue
            self.addChild(popUp!)
        }
    }
    func resume() {
        self.scene?.paused = false
        selectedPlayer.lastUpdatePower = NSDate()
        self.popUpOpened = false
    }
    func reset() {
        
        shouldShowAd()
        cleanScene()
        
        let scene = GenericGameScene.createScene(self.size, levelIndex: levelIndex)
        let transition = SKTransition.fadeWithDuration(0.5)
        self.view?.presentScene(scene, transition: transition)
    }
    
    private func GameOver() {
       
        
        self.popUp = GameOverMenu.createGameOverMenu(UIScreen.mainScreen().bounds.size)
        self.popUp?.position = CGPointMake(self.frame.size.width/2,self.frame.size.height/2)
        self.scene?.paused = true
        self.popUpOpened = true
        self.popUp!.zPosition = ZPositionEnum.PopUp.rawValue
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
        self.popUp!.zPosition = ZPositionEnum.PopUp.rawValue
        self.popUp?.userInteractionEnabled = true
        self.addChild(popUp!)
    }
    
}
