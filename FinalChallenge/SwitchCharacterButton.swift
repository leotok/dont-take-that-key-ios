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
    private var bar:SKSpriteNode!
    private let initialDuration:Double
    
    init(characterImage:String) {
        self.characterImage = UIImage(named: "Sam_bolinha")!
        let texture = SKTexture(image: self.characterImage)
        texture.filteringMode = SKTextureFilteringMode.Nearest
        self.initialDuration = 10
        
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(50, 50))
        
        bar = SKSpriteNode(texture: nil, color: SKColor.yellowColor(), size: CGSizeMake(self.size.width, 5))
        bar.anchorPoint = CGPointZero
        
        bar.position = CGPointMake(-bar.size.width/2,-self.size.height/2-bar.size.height)
        self.addChild(bar)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateBar:", name: "UpdatePowerBar", object: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBar(sender:AnyObject){
        print("atualizeibarra")
        
        
        
    }
    
    
}
