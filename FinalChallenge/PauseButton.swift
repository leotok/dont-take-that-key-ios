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
    
    var pauseImage: UIImage
    
    init() {
        self.pauseImage = UIImage(named: "pause")!
        let texture = SKTexture(image: self.pauseImage)
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(60, 60))
        self.alpha = 0.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//    }
}

