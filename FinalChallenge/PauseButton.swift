//
//  PauseButton.swift
//  FinalChallenge
//
//  Created by Hugo Manhães on 9/29/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class PauseButton: SKSpriteNode{
    
    var screenHeight = UIScreen.mainScreen().bounds.width
    var pauseImage: UIImage
    
    init() {
        self.pauseImage = UIImage(named: "pause")!
        let texture = SKTexture(image: self.pauseImage)
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(screenHeight / 9.46, screenHeight / 9.46))
        self.alpha = 0.4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

