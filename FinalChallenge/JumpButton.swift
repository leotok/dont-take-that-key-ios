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
    
    init(jumpImage:String) {
        self.jumpImage = UIImage(named: jumpImage)!
        let texture = SKTexture(image: self.jumpImage)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
}
