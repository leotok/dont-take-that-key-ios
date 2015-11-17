//
//  RightButton.swift
//  FinalChallenge
//
//  Created by Hugo Manhães on 9/29/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class RightButton: SKSpriteNode{
    
    var rightImage: UIImage
    var characterSingleton: CurrentCharacterSingleton
    
    init() {
        self.rightImage = UIImage(named: "right")!
        let texture = SKTexture(image: self.rightImage)
        characterSingleton = CurrentCharacterSingleton.sharedInstance
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(60, 60))
        self.alpha = 0.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        characterSingleton = CurrentCharacterSingleton.sharedInstance
//        characterSingleton.currentCharacter!.walkRight()
//    }
    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        characterSingleton.currentCharacter!.stopWalking()
//    }
}
