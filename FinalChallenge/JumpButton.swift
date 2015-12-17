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
    var screenHeight = UIScreen.mainScreen().bounds.width
    
    init() {
        self.jumpImage = UIImage(named: "jump")!
        let texture = SKTexture(image: self.jumpImage)
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(screenHeight / 9.46, screenHeight / 9.46))
        self.alpha = 0.4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
