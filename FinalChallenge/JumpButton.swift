//
//  JumpButton.swift
//  FinalChallenge
//
//  Created by Hugo Manhães on 9/29/15.
//  Copyjump © 2015 Hjlmt. All jumps reserved.
//

import Foundation
import SpriteKit

class JumpButton: SKSpriteNode{
    
    var jumpImage: UIImage
    
    init() {
        self.jumpImage = UIImage(named: "jump")!
        let texture = SKTexture(image: self.jumpImage)
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(60, 60))
        self.alpha = 0.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
