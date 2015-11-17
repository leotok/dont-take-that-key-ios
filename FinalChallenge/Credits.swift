//
//  Credits.swift
//  FinalChallenge
//
//  Created by Mayara Gasparini Dias  on 17/11/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

class Credits: SKScene {
    
    override func didMoveToView(view: SKView) {

    
    let dao = DAOUserInfo()
 
        
        
        let background = SKSpriteNode(imageNamed: "wallpaper1")
        background.position = CGPointMake( self.size.width / 2 , self.size.height / 2 )
        background.size = self.size
        background.alpha = 1
        
        addChild(background)

    
        let credits = SKLabelNode(fontNamed: "Pixel-Art")
        credits.text = NSLocalizedString("Credits", comment: "")
        credits.position = CGPointMake(self.size.width/2, 340)
        credits.name = "credits"
        credits.zPosition = ZPositionEnum.Button.rawValue
        credits.fontColor = SKColor.blackColor()
    
        addChild(credits)
        
        let hugo = SKLabelNode(fontNamed: "Pixel-Art")
        hugo.text = NSLocalizedString("Hugo", comment: "")
        hugo.position = CGPointMake(self.size.width/2, 290)
        hugo.name = "hugo"
        hugo.zPosition = ZPositionEnum.Button.rawValue
        hugo.fontColor = SKColor.blackColor()
        
        addChild(hugo)
        
        let leo = SKLabelNode(fontNamed: "Pixel-Art")
        leo.text = NSLocalizedString("Leo", comment: "")
        leo.position = CGPointMake(self.size.width/2, 240)
        leo.name = "leo"
        leo.zPosition = ZPositionEnum.Button.rawValue
        leo.fontColor = SKColor.blackColor()
        
        addChild(leo)
        
        let thiago = SKLabelNode(fontNamed: "Pixel-Art")
        thiago.text = NSLocalizedString("Thiago", comment: "")
        thiago.position = CGPointMake(self.size.width/2, 190)
        thiago.name = "thiago"
        thiago.zPosition = ZPositionEnum.Button.rawValue
        thiago.fontColor = SKColor.blackColor()
        
        addChild(thiago)

        let julia = SKLabelNode(fontNamed: "Pixel-Art")
        julia.text = NSLocalizedString("Julia", comment: "")
        julia.position = CGPointMake(self.size.width/2, 140)
        julia.name = "julia"
        julia.zPosition = ZPositionEnum.Button.rawValue
        julia.fontColor = SKColor.blackColor()
        
        addChild(julia)

        let mayara = SKLabelNode(fontNamed: "Pixel-Art")
        mayara.text = NSLocalizedString("Mayara", comment: "")
        mayara.position = CGPointMake(self.size.width/2, 90)
        mayara.name = "mayara"
        mayara.zPosition = ZPositionEnum.Button.rawValue
        mayara.fontColor = SKColor.blackColor()
        
        addChild(mayara)




    }


















}