//
//  LevelGenerator.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

enum LevelTheme {
    
    case Sam
    case Shrink
    case Ellie
    case AllChar
    
}

class LevelGenerator {
    
    var levelMatrix: Array<String>!
    var levelScene: GenericGameScene!
    var levelIndex = 0

    let numberOfVerticalTiles = 13
    let numberOfHorizontalTiles = 24
    let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
    let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375  // 32 pts. Mesmo calculo para width e height para manter a proporcao 1x1 em qualquer device
    
    func loadLevel(level:Int , scene:GenericGameScene )->Bool {
  
        levelIndex = level
        levelScene = scene
        
        
        getLevelMatrixFromTxt()
        defineLevelTheme()
        //printLevelMatrixLog()
        generateNodes()
        
        return true
    }
    
    private func getLevelMatrixFromTxt() {
     
        let levelPath = "Level_\(levelIndex)"
        
        if let path = NSBundle.mainBundle().pathForResource(levelPath, ofType: "txt")
        {
            
            var data: String!
            
            do {
                data = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            } catch {
                print("Error reading .txt file.")
            }
        
            if let content = (data){
                levelMatrix =  content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
                print("Read data")
            }
            else {
                print("Couldnt read data.")
            }
        }
        else {
            print("Couldnt find txt.")
        }
    }
    
    private func defineLevelTheme() -> LevelTheme {
        
        switch (levelIndex) {
            
        case 1...6:
            return LevelTheme.Sam
            
        case 7...12:
            return LevelTheme.Shrink
            
        case 13...18:
            return LevelTheme.Ellie
            
        default:
            return LevelTheme.Sam
        }
    }

    private func printLevelMatrixLog() {
    
        for i in 0...(self.numberOfVerticalTiles - 1) {
            
            for j in 0...(self.numberOfHorizontalTiles - 1) {
                
                let string = levelMatrix[i]
                let index = string.startIndex.advancedBy(1)
                print("\(i)\(j):  \(string[index])")
            }
        }
    }
    
    private func generateNodes() {
        
        for i in 0...(self.numberOfVerticalTiles - 1)
        {
            let string = levelMatrix[i]
            var index = string.startIndex
            for j in 0...(self.numberOfHorizontalTiles - 1)
            {
                if let tile: GenericObject = getNodeType( string[index] )
                {
                    tile.position = CGPointMake(  spriteWidth * CGFloat( (j) )  , (spriteHeight / 2) + spriteHeight * CGFloat( (numberOfVerticalTiles - i - 1) ) )
                    levelScene.pausableLayer.addChild(tile)
                }
                index = index.advancedBy(1)
            }
        }
    }
    
    private func getNodeType(nodeType: Character)-> GenericObject? {
        
        var tile: GenericObject!
        
        switch (nodeType) {
            
            case "1":
            
            tile = StaticObject(sprite: SKTexture())
            tile.color = SKColor.redColor()
            tile.size = CGSizeMake(spriteWidth, spriteHeight)
            tile.physicsBody?.contactTestBitMask = playerCategory
            
            case "2":
            
            tile = KeyNode()
            
            case "3":
            
            tile = MovableObject(sprite: SKTexture(imageNamed: "crate"))
            tile.physicsBody?.usesPreciseCollisionDetection = true
            tile.size = CGSizeMake(spriteWidth, spriteHeight)
            
            case "4":
            
            tile = DoorNode()
            
            case "5":
            
            tile = StaticObject(sprite: SKTexture(imageNamed: "spike"))
            tile.size = CGSizeMake(spriteWidth, spriteHeight)
            tile.physicsBody?.usesPreciseCollisionDetection = true
            tile.physicsBody?.categoryBitMask = hazardCategory
            tile.physicsBody?.collisionBitMask = objectCategory | playerCategory
            tile.physicsBody?.contactTestBitMask = playerCategory
            
            case "0":
                break;
            default:
            print("Node type inside .txt doesnt exists.")
        }
        
        return tile
    }
}