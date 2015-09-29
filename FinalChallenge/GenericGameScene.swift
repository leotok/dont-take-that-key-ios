//
//  GameScene.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 24/09/15.
//  Copyright (c) 2015 Hjlmt. All rights reserved.
//

import SpriteKit

class GenericGameScene: SKScene, GeneratorDelegate, Pausable {
    
    var levelIndex = 0
    var level = -1
    var hud:HUD!
    var selectedPlayer:Character!
    var characters:[Character]!
    var gameLayer:SKNode!
    var pausableLayer:SKNode!
    

    
    override func didMoveToView(view: SKView) {
        
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
        
        /* Setup your scene here */
        hud = HUD()
        self.addChild(self.hud)
        hud.zPosition = 100
        
        
        gameLayer = SKNode()
        gameLayer.zPosition = 50
        self.addChild(gameLayer)
        
        pausableLayer = SKNode()
        gameLayer.addChild(pausableLayer)
        
        
        let lvlGen = LevelGenerator()
        lvlGen.loadLevel(self.level)

        
    }
    
    func addNodeToScene(node: SKNode) {
        self.addChild(node)
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
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
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
