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
    var characterSingleton: CurrentCharacterSingleton
    
    init(powerImage:String) {
        self.powerImage = UIImage(named: "power")!
        let texture = SKTexture(image: self.powerImage)
        characterSingleton = CurrentCharacterSingleton()
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(60, 60))
        self.alpha = 0.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        //characterSingleton = CurrentCharacterSingleton()
//        characterSingleton.currentCharacter?.usePower()
//    }
}
