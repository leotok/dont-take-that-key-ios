//
//  PowerButton.swift
//  FinalChallenge
//
//  Created by Hugo Manhães on 9/29/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class PowerButton: SKSpriteNode{
    
    var powerImage: UIImage
    
    init(powerImage:String) {
        self.powerImage = UIImage(named: powerImage)!
        let texture = SKTexture(image: self.powerImage)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
}
