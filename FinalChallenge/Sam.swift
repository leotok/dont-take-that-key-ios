//
//  Sam.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class Sam: Character {
    
    init () {
    
        //Setting Sam`s properties
    
        
        
        super.init(sprite: SKTexture(imageNamed: "Sam_Idle"))
    
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}