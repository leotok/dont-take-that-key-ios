//
//  SwitchCharacterButton.swift
//  FinalChallenge
//
//  Created by Hugo Manhães on 9/29/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class SwitchCharacterButton: SKSpriteNode{
    
    var characterImage: UIImage
    
    init(characterImage:String) {
        self.characterImage = UIImage(named: "character")!
        let texture = SKTexture(image: self.characterImage)
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(50, 50))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
}
