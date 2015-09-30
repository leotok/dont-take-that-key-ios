//
//  LeftButton.swift
//  FinalChallenge
//
//  Created by Hugo Manhães on 9/29/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class LeftButton: SKSpriteNode{
    
    var leftImage: UIImage
    
    init(leftImage:String) {
        self.leftImage = UIImage(named: leftImage)!
        let texture = SKTexture(image: self.leftImage)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
}