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
class Sam: Character {
    
    var delegate:Pausable?
    
    init () {
    
        //Setting Sam`s properties
        super.init(sprite: SKTexture(imageNamed: "Sam_Idle"))
        self.walkTextures = [SKTexture]()
        self.jumpTextures = [SKTexture]()
    
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