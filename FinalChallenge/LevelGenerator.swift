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
    var theme: LevelTheme!
    var levelIndex = 0

    let numberOfVerticalTiles = 13
    let numberOfHorizontalTiles = 24
    let spriteWidth: CGFloat = 32
    let spriteHeight: CGFloat = 32
    
    func loadLevel(level:Int , scene:GenericGameScene )->Bool {
  
        levelIndex = level
        levelScene = scene
        
        
        getLevelMatrixFromTxt()
        defineLevelTheme()
        //printLevelMatrixLog()
        generateNodes()
        
        return true
    }
    
    func getLevelMatrixFromTxt() {
     
        if let path = NSBundle.mainBundle().pathForResource("Level_Test", ofType: "txt"){
            
            var data: String!
            
            do {
                data = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            } catch {
                print("Error reading .txt file")
            }
        
            if let content = (data){
                levelMatrix =  content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
                print("Read data")
            }
            else {
                print("Couldnt read data")
            }
        }
        else {
            print("Couldnt find txt")
        }
    }
    
    func defineLevelTheme() {
        
        switch (levelIndex) {
            
        case 1...6:
            theme = LevelTheme.Sam
            break
            
        case 7...12:
            theme = LevelTheme.Shrink
            break
            
        case 13...18:
            theme = LevelTheme.Ellie
            break
            
        default:
            theme = LevelTheme.Sam
            break
        }
    }

    func printLevelMatrixLog() {
    
        for i in 0...(self.numberOfVerticalTiles - 1) {
            
            for j in 0...(self.numberOfHorizontalTiles - 1) {
                
                let string = levelMatrix[i]
                let index = string.startIndex.advancedBy(1)
                print("\(i)\(j):  \(string[index])")
            }
        }
    }
    
    func generateNodes() {
        
        for i in 0...(self.numberOfVerticalTiles - 1)
        {
            let string = levelMatrix[i]
            var index = string.startIndex
            for j in 0...(self.numberOfHorizontalTiles - 1)
            {
                if let tile: GenericObject = getNodeType( string[index] )
                {
                    tile.position = CGPointMake(  spriteWidth * CGFloat( (j) )  , 16 + spriteHeight * CGFloat( (numberOfVerticalTiles - i - 1) ) )
                    levelScene.pausableLayer.addChild(tile)
                }
                index = index.advancedBy(1)
            }
        }
    }
    
    func getNodeType(nodeType: Character)-> GenericObject? {
        
        var tile: GenericObject!
        
        switch (nodeType) {
            
            case "1":
            
            tile = StaticObject(sprite: SKTexture())
            tile.color = SKColor.blueColor()
            tile.size = CGSizeMake(spriteWidth, spriteHeight)
            
            case "2":
            
            tile = StaticObject(sprite: SKTexture(imageNamed: "key"))
            tile.size = CGSizeMake(spriteWidth, spriteHeight)
            
            case "3":
            
            tile = MovableObject(sprite: SKTexture(imageNamed: "crate"))
            tile.size = CGSizeMake(spriteWidth, spriteHeight)
            
            case "0":
            print("No nodes here.")
            default:
            print("Node type inside .txt doesnt exists.")
        }
        
        return tile
    }
}