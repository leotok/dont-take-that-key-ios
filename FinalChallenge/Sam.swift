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
        let texture1 = SKTexture(imageNamed: "Sam_Idle2")
        texture1.filteringMode = SKTextureFilteringMode.Nearest
        let texture2 = SKTexture(imageNamed: "Sam_Idle1")
        texture2.filteringMode = SKTextureFilteringMode.Nearest
        super.init(sprite:[texture1,texture2])
        //self.physicsBody = SKPhysicsBody(texture: self.texture!, size: (self.texture?.size())!)
        self.walkTextures = [SKTexture]()
        self.jumpTextures = [SKTexture]()
        
        var walkingTexures = [SKTexture]()
        
        for i in 1...4 {
            let texture = SKTexture(imageNamed: "Sam_Walk\(i)")
            texture.filteringMode = SKTextureFilteringMode.Nearest
            walkingTexures.append(texture)
        }
        self.setWalkingTextures(walkingTexures)
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(delegate: Pausable){
        self.delegate = delegate
    }
    
     internal override func activatePower() {
        print("row row")
        super.activatePower()
        print("fight the powa")
        self.delegate?.pauseScene()
        print(self.delegate)
    }
    internal override func deactivatePower() {
        super.deactivatePower()
        self.delegate?.unpauseScene()
    }

    
}