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
    
    let numberOfVerticalTiles = 6
    let numberOfHorizontalTiles = 14
    
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
            var index = string.startIndex //advancedBy(1)
            for j in 0...(self.numberOfHorizontalTiles - 1)
            {
                if string[index] ==  "1" {
                    let tile = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(64, 64))
                    tile.position = CGPointMake( -32 + 64 * CGFloat( (numberOfHorizontalTiles - j - 1) )  , 32 + 64 * CGFloat( (numberOfVerticalTiles - i - 1) ) )
                    tile.zPosition = 10
                    tile.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(64, 64))
                    tile.physicsBody?.categoryBitMask = 2
                    tile.physicsBody?.collisionBitMask = 1 | 2
                    tile.physicsBody?.affectedByGravity = false
                    tile.physicsBody?.allContactedBodies()
                    tile.physicsBody?.allowsRotation = false
                    tile.physicsBody?.restitution = 0
                    tile.physicsBody?.dynamic = false
                    tile.physicsBody?.usesPreciseCollisionDetection = true
                    levelScene.pausableLayer.addChild(tile)
                }
                index = index.advancedBy(1)
            }
        }
    }
}