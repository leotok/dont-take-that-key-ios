//
//  Sam.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

protocol Pausable {
    
    func pauseScene()->Bool
    func unpauseScene()->Bool
    
}
class Sam: GameCharacter{
    
    var delegate:Pausable?
    
    init () {
    

        //Setting Sam`s properties
        let texture = SKTexture(imageNamed: "Sam_Idle")
        texture.filteringMode = SKTextureFilteringMode.Nearest
        super.init(sprite: texture)
        //self.physicsBody = SKPhysicsBody(texture: self.texture!, size: (self.texture?.size())!)
        self.walkTextures = [SKTexture]()
        self.jumpTextures = [SKTexture]()
        
        var walkingTexures = [SKTexture]()
        
        for i in 1...4 {
            let texture = SKTexture(imageNamed: "Sam_Walk\(i)")
            texture.filteringMode = SKTextureFilteringMode.Nearest
            walkingTexures.append(texture)
            print(i)
        }
        self.setWalkingTextures(walkingTexures)
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     internal override func activePower() {
        super.activePower()
        self.delegate?.pauseScene()
        
    }
    internal override func deactivatePower() {
        super.deactivatePower()
        self.delegate?.unpauseScene()
    }

    
}