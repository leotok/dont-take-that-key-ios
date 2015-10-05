//
//  GenericObject.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit


class GenericObject: SKSpriteNode {
 
    init (sprite:SKTexture) {
        
        super.init(texture: sprite, color: UIColor.clearColor(), size: CGSizeMake(32, 32))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}