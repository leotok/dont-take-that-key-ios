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
    
    var screenHeight = UIScreen.mainScreen().bounds.width
    var leftImage: UIImage
    
    init() {
        self.leftImage = UIImage(named: "left")!
        let texture = SKTexture(image: self.leftImage)
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(screenHeight / 9.46, screenHeight / 9.46))
        self.alpha = 0.4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}