//
//  GameScene.swift
//  FinalChallenge
//
//  Created by Leonardo Edelman Wajnsztok on 24/09/15.
//  Copyright (c) 2015 Hjlmt. All rights reserved.
//

import SpriteKit

class GenericGameScene: SKScene, GeneratorDelegate {
    
    
    var level = -1
    var hud:HUD!
    var selectedPlayer:Character!
    var characters:[Character]!
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.hud = HUD()
        self.addChild(self.hud)
        hud.zPosition = 100
        
        
        
        let lvlGen = LevelGenerator()
        lvlGen.loadLevel(self.level)

        
    }
    
    func addNodeToScene(node: SKNode) {
        self.addChild(node)
    }
    

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
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
