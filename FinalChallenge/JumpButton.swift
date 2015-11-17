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
    var characterSingleton: CurrentCharacterSingleton
    
    init() {
        self.jumpImage = UIImage(named: "jump")!
        let texture = SKTexture(image: self.jumpImage)
        characterSingleton = CurrentCharacterSingleton.sharedInstance
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(60, 60))
        self.alpha = 0.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        characterSingleton = CurrentCharacterSingleton.sharedInstance
//        characterSingleton.currentCharacter!.jump()
//    }
    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        characterSingleton = CurrentCharacterSingleton.sharedInstance
//        if(characterSingleton.currentCharacter!.isJumping == true){
//            characterSingleton.currentCharacter?.removeActionForKey("Jump")
//            characterSingleton.currentCharacter!.stopImpulse()
//        }
//    }
    
}
