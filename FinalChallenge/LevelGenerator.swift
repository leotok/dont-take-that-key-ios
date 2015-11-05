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
    var levelTheme: LevelTheme!
    var levelScene: GenericGameScene!
    var levelIndex = 0
    var levelRatio: Int = 1

    var numberOfControlTiles = 0
    let numberOfVerticalTiles = 13
    let numberOfHorizontalTiles = 24
    let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
    let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375  // 32 pts. Mesmo calculo para width e height para manter a proporcao 1x1 em qualquer device
    
    func loadLevel(level:Int , scene:GenericGameScene )->Bool {
  
        levelIndex = level
        levelScene = scene
        levelTheme = defineLevelTheme()
    
        if levelTheme == .Shrink || levelTheme == .Ellie || levelTheme == .AllChar {
            self.levelRatio = 2
        }
        
        let time = NSDate()
        getLevelMatrixFromTxt()
        addCorrespondingBackground()
        //printLevelMatrixLog()
        generateNodes()
        addCharacterToGameScene()
        
        print("\(NSDate().timeIntervalSinceDate(time)) seconds to load level")
        return true
    }
    
    func getLevelSize()->CGSize{
        let size = CGSize(width: CGFloat(self.numberOfHorizontalTiles) * CGFloat(levelRatio) * spriteWidth, height: CGFloat(self.numberOfVerticalTiles) * CGFloat(levelRatio) * spriteHeight)
        return size
    }
    
    private func addCharacterToGameScene() {
    
        let player = Sam()
        player.setDelegate(levelScene)
        levelScene.selectedPlayer = player
        levelScene.selectedPlayer.position = CGPointMake(50, 300)
        //levelScene.selectedPlayer.position = CGPointMake(400, 600)
        levelScene.addChild(levelScene.selectedPlayer)
    
    }
    
    private func addCorrespondingBackground() {
        
        if let theme = levelTheme {
            switch (theme) {
                
            case LevelTheme.Sam:
                
                let background = SKSpriteNode(imageNamed: "gameplayBackground")
                background.color = SKColor.blueColor()
                background.position = CGPointMake( self.levelScene.size.width / 2 , self.levelScene.size.height / 2 )
                background.size = self.levelScene.size
                background.texture?.filteringMode = SKTextureFilteringMode.Nearest
                background.zPosition = ZPositionEnum.Background.rawValue
                levelScene.addChild(background)
                
            case LevelTheme.Shrink:
                break

            case LevelTheme.Ellie:
                break
                
            case LevelTheme.AllChar:
                break
            }
        }
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
            print("Couldnt find txt with path: \(levelPath).")
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
    
        
        for i in 0...(levelRatio * self.numberOfVerticalTiles - 1)
        {
            let string = levelMatrix[i]
            var index = string.startIndex
            for j in 0...(levelRatio * self.numberOfHorizontalTiles - 1)
            {
                if let tile: SKSpriteNode = getNodeType( string[index] )
                {
                    tile.position = CGPointMake(  spriteWidth * CGFloat( (j) )  , (spriteHeight / 2) + spriteHeight * CGFloat( (levelRatio * numberOfVerticalTiles - i - 1) ) )
                    levelScene.pausableLayer.addChild(tile)
                }
                index = index.advancedBy(1)
            }
        }
    }
    
    private func getNodeType(nodeType: Character)-> SKSpriteNode? {
        
        var tile: SKSpriteNode!
        
        switch (nodeType) {
            
            case "1":
            
                let i = 1 //Int.random(2...5)
                tile = StaticObject(sprite: SKTexture(imageNamed: "Ground_\(i)"))
                tile.size = CGSizeMake(spriteWidth, spriteHeight)
                tile.physicsBody?.contactTestBitMask = playerCategory
            
            case "2":
            
                tile = KeyNode()
            
            case "3":
            
                tile = CrateNode()
            
            case "4":
            
                tile = DoorNode()
            
            case "5":
            
                tile = SpikeNode()
            
            case "6":
            
                let i = 1 //Int.random(1...4)
                tile = StaticObject(sprite: SKTexture(imageNamed: "groundTop\(i)"))
                tile.color = SKColor.redColor()
                tile.size = CGSizeMake(spriteWidth, spriteHeight)
                tile.physicsBody?.contactTestBitMask = playerCategory
            
            case "7":
            
                tile =  ControlTile.createControlTile()
                numberOfControlTiles++
                (tile as! ControlTile).number = numberOfControlTiles
            
            case "8":
            
                tile = ClockHandNode()
            
            case "9":
            
                tile = AmpulhetaNode()
                
            case "0":
                
                break;
            
            default:
                print("Node type inside .txt doesnt exists.")
        }
        
        return tile
    }
    
    private func attachDebugRectWithSize(s: CGSize, node: SKSpriteNode) {
        let bodyPath = CGPathCreateWithRect(CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height), nil)
        attachDebugFrameFromPath(bodyPath, node: node)
    }
    
    private func attachDebugFrameFromPath(bodyPath: CGPathRef, node: SKSpriteNode) {
        let shape = SKShapeNode()
        shape.path = bodyPath
        shape.strokeColor = SKColor.yellowColor()
        shape.lineWidth = 1.0
        node.addChild(shape)
    }
}