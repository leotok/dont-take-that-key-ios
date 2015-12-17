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
    
    var screenHeight = UIScreen.mainScreen().bounds.width
    var characterImage: UIImage
    private var initialTexturePos = 0
    private var bar:SKSpriteNode!
    private let initialDuration:Double
    private var initialWidth:CGFloat
    var textures = [SKTexture]()
    
    init(characterImage:String) {
        self.characterImage = UIImage(named: "Sam_bolinha1")!
        let texture = SKTexture(image: self.characterImage)
        texture.filteringMode = SKTextureFilteringMode.Nearest
        
        let texture2 = SKTexture(imageNamed: "Sam_bolinha2")
        texture2.filteringMode = .Nearest
        
        textures.append(texture)
        textures.append(texture2)
    
        self.initialDuration = 10
        initialWidth = 0

        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(50, 50))
        
        initialWidth = self.frame.size.width
        bar = SKSpriteNode(texture: nil, color: SKColor.yellowColor(), size: CGSizeMake(initialWidth, 5))
        bar.anchorPoint = CGPointZero
        
        bar.position = CGPointMake(-bar.size.width/2,-self.size.height/2-bar.size.height)
        self.addChild(bar)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateBar:", name: "UpdatePowerBar", object: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBar(sender:AnyObject) {

        if let percentage = CurrentCharacterSingleton.sharedInstance.currentCharacter?.getPercentagePower() {
        
            if percentage == 0.0 {

                CurrentCharacterSingleton.sharedInstance.currentCharacter?.texture = CurrentCharacterSingleton.sharedInstance.currentCharacter?.idleTextures[0]
                changeSwitchButtonImage()
            }
            
            bar.removeFromParent()
            let size = initialWidth * CGFloat(percentage)
            bar = SKSpriteNode(texture: nil, color: SKColor.yellowColor(), size: CGSizeMake(size, 5))
            bar.anchorPoint = CGPointZero
            
            bar.position = CGPointMake(-initialWidth/2,-self.size.height/2-bar.size.height)
            self.addChild(bar)
            
            
        }
        
    }
    
    func changeSwitchButtonImage() {
        
        if CurrentCharacterSingleton.sharedInstance.currentCharacter?.powerDuration > 0 {
            if initialTexturePos == 0 {
                initialTexturePos = 1
            }
            else {
                initialTexturePos = 0
            }
        
            self.texture = textures[initialTexturePos]
        }
        else {
            self.texture = textures[0]
        }
    
    }
    
    
}
