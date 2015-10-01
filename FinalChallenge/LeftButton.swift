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
    var characterSingleton: CurrentCharacterSingleton
    
    init() {
        self.leftImage = UIImage(named: "left")!
        let texture = SKTexture(image: self.leftImage)
        characterSingleton = CurrentCharacterSingleton.sharedInstance
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(60, 60))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        characterSingleton = CurrentCharacterSingleton.sharedInstance
        characterSingleton.currentCharacter!.walkLeft()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        characterSingleton.currentCharacter!.stopWalking()
    }
}