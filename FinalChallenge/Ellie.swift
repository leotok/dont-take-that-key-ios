//
//  Ellie.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit


class Ellie: Character {
   
    init () {
        
        //Setting Ellie`s properties
        
        
        
        super.init(sprite: SKTexture(imageNamed: "Ellie_Idle"))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}