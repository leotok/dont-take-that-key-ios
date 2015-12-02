////
////  MooreLevelGenerator.swift
////  MooreContourTracing
////
////  Created by Leonardo Edelman Wajnsztok on 22/10/15.
////  Copyright © 2015 LeonardoWajnsztok. All rights reserved.
////
//
//
//// IMPORTANTE!
//
////TODO: melhorar a criação do shape pra evitar wall jump
////TODO: shapes muito proximos (1 tile de distancia) fazem com a leitura saia errada ou até entre em loop
////TODO: shapes em algumas das margens dao problema de leitura
//
//
//import UIKit
//import SpriteKit
//import Darwin
//
////enum TileType {
////    
////    case Floor
////    case Wall
////    case Empty
////}
////
////enum Direction {
////    case NorthWest
////    case North
////    case NorthEast
////    case East
////    case SouthEast
////    case South
////    case SouthWest
////    case West
////}
////
////struct TilePoint {
////    var i: Int
////    var j: Int
////}
////
////struct ContourLine {
////    var point: TilePoint
////    var direction: Direction
////}
//
//class MooreLevelGenerator {
//    
//    private var levelMatrix: Array<String>!
//    private var mooreMatrix: Array<String>!
//    private var shapesArray = Array<Array<ContourLine>>()
//    private var levelScene: SKScene?
//    
//    var levelRatio: Int?
//    var levelIndex = 1
//    let numberOfVerticalTiles = 13
//    let numberOfHorizontalTiles = 24
//    let spriteWidth: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375
//    let spriteHeight: CGFloat = UIScreen.mainScreen().bounds.height / 12.9375  // 32 pts. Mesmo calculo para width e height para manter a proporcao 1x1 em qualquer device
//    
//    func loadLevel(scene:GenericGameScene, index: Int, levelRatio: Int)->Bool {
//        
//        levelScene = scene
//        levelIndex = index
//        
//        self.levelRatio = levelRatio
//        
//        let startTime = NSDate()
//        
//        getLevelMatrixFromTxt()
//        mooreMatrix = levelMatrix
//        
//        let alphabet = "abcdefghijklmnopqrstuvwxyz"
//        var startingChar = getCharFromStringAtIndex(alphabet, index: 0)
//        var line = defineStartingPoint("1",contourChar: "a")
//        
//        for var i = 1; i < 26 && (line.point.i >= 0 && line.point.j >= 0) ; i++ {
//            
//            var array = Array<ContourLine>()
//            array.append(line)
//            if line.point.i >= 0 && line.point.j >= 0 {
//                traceContourForChar(&array,tracedChar: "1", contourChar: startingChar, start: line.point, point: line.point, startingDir: line.direction)
//                shapesArray.append(array)
//                startingChar = getCharFromStringAtIndex(alphabet, index: i)
//                line = defineStartingPoint("1",contourChar: startingChar)
//            }
//        }
//        
//        print("Generated in \(NSDate().timeIntervalSinceDate(startTime)) seconds.")
//        
//        for shape in shapesArray {
//            createNodeForContourLines(shape)
//        }
//        
//        return true
//    }
//    
//    private func defineStartingPoint(tracedChar: Character, contourChar: Character) -> ContourLine {
//        
//        for i in 0...(numberOfVerticalTiles*levelRatio! - 1) {
//            
//            let string: String = mooreMatrix[i]
//            
//            for j in 1...(numberOfHorizontalTiles*levelRatio! - 1) {
//                
//                let char: Character = getCharFromStringAtIndex(string, index: j)
//                
//                
//                if  char == tracedChar || char == "6"{
//                    let northCase = i > 0 && getCharFromStringAtIndex(mooreMatrix[i-1], index: j) == "0"
//                    let southCase = i < numberOfVerticalTiles*levelRatio! - 1 && getCharFromStringAtIndex(mooreMatrix[i+1], index: j) == "0"
//                    let eastCase = j < numberOfHorizontalTiles*levelRatio! - 1 && getCharFromStringAtIndex(mooreMatrix[i], index: j+1) == "0"
//                    let westCase = j > 0 && getCharFromStringAtIndex(mooreMatrix[i], index: j-1) == "0"
//                    
//                    if eastCase || westCase || southCase || northCase {
//                        print("Found! \(char)")
//                        mooreMatrix[i] = replaceCharFromStringAtIndex(mooreMatrix[i], index: j, char: contourChar)
//                        let start = TilePoint(i: i, j: j)
//                        let line = ContourLine(point: start, direction: .South)
//                        return line
//                    }
//                }
//            }
//        }
//        print("Dint find any starting point.")
//        let noLine = ContourLine(point: TilePoint(i: -1, j: -1), direction: .South)
//        return noLine
//    }
//    
//    private func getCharFromStringAtIndex(string: String, index: Int) ->  Character {
//        
//        let i = string.startIndex.advancedBy(index)
//        return string[i]
//    }
//    
//    private func replaceCharFromStringAtIndex(string: String, index: Int, char: Character)-> String{
//        
//        var newString = string as NSString
//        
//        newString = (string as NSString).stringByReplacingCharactersInRange(NSMakeRange(index, 1), withString: String(char))
//        
//        return newString as String
//    }
//    
//    private func getLevelMatrixFromTxt() {
//        
//        let levelPath = "Level_\(levelIndex)"
//        
//        if let path = NSBundle.mainBundle().pathForResource(levelPath, ofType: "txt")
//        {
//            
//            var data: String!
//            
//            do {
//                data = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
//            } catch {
//                print("Error reading .txt file.")
//            }
//            
//            if let content = (data){
//                levelMatrix =  content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
//                print("Read data")
//            }
//            else {
//                print("Couldnt read data.")
//            }
//        }
//        else {
//            print("Couldnt find txt with path: \(levelPath).")
//        }
//    }
//    
//    private func printLevelMatrixLog(array: Array<String>) {
//        
//        for i in 0...(self.numberOfVerticalTiles*levelRatio! - 1) {
//            
//            print(String(format: "%02d %@", i, array[i]))
//        }
//        print("\n")
//    }
//    
//    private func createNodeForContourLines(contourLinesArray: Array<ContourLine>) {
//        
//        let path = CGPathCreateMutable()
//        
//        let initialPoint = contourLinesArray.first?.point
//        if contourLinesArray.count == 1 {
//            CGPathMoveToPoint(path, nil, CGFloat(initialPoint!.j ) * spriteHeight, CGFloat(initialPoint!.i + 1) * spriteWidth)
//        }
//        else {
//            CGPathMoveToPoint(path, nil, CGFloat(initialPoint!.j + 1) * spriteHeight, CGFloat(initialPoint!.i + 1) * spriteWidth)
//        }
//
//        for k in 0...contourLinesArray.count - 1 {
//            
//            let line = contourLinesArray[k]
//            var nextLine: ContourLine!
//            if k == contourLinesArray.count - 1 {
//                nextLine = contourLinesArray.first
//            }
//            else {
//                nextLine = contourLinesArray[k + 1]
//            }
//            
//            switch (line.direction) {
//            case .North:
//                if (line.point.i == nextLine.point.i  && line.point.j == nextLine.point.j - 1) || (line.point.i == nextLine.point.i + 1  && line.point.j == nextLine.point.j - 1 ) {
//                    // caso desenha apenas uma linha
//                    //print("1 line north.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i) * spriteHeight)
//                }
//                else if (line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j - 1 ) || ( line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j ) {
//                    //caso desenha 2 linhas
//                    //print("2 line north.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                }
//                else if ( line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j + 1 ) || ( line.point.i == nextLine.point.i  && line.point.j == nextLine.point.j + 1 ) {
//                    //case desenha 3 linhas
//                    //print("3 line north.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                }
//                else {
//                    print("Outro caso de North.")
//                }
//                
//            case .South:
//                if ( line.point.i == nextLine.point.i  && line.point.j == nextLine.point.j + 1 ) || ( line.point.i == nextLine.point.i - 1  && line.point.j == nextLine.point.j + 1 )  {
//                    // caso desenha apenas uma linha
//                    //print("1 line south.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                }
//                else if ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j + 1 ) ||  ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j ) {
//                    //caso desenha 2 linhas
//                    //print("2 line south.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i) * spriteHeight)
//                }
//                else if ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j - 1 ) || ( line.point.i == nextLine.point.i && line.point.j == nextLine.point.j - 1 ) {
//                    //case desenha 3 linhas
//                    //print("3 line south.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
//                }
//                else {
//                    //print("4 lines south.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1 ) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i + 1 ) * spriteHeight)
//                }
//                
//            case .West:
//                if (line.point.i == nextLine.point.i + 1  && line.point.j == nextLine.point.j ) || ( line.point.i == nextLine.point.i + 1  && line.point.j == nextLine.point.j + 1 ) {
//                    // caso desenha apenas uma linha
//                    //print("1 line west.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
//                }
//                else if ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j - 1 ) || ( line.point.i == nextLine.point.i && line.point.j == nextLine.point.j - 1 ) {
//                    //caso desenha 2 linhas
//                    //print("2 line west.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
//                }
//                else if ( line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j - 1 ) || ( line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j ) {
//                    //case desenha 3 linhas
//                    //print("3 line west.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                }
//                else {
//                    print("Outro caso de West.")
//                }
//                
//            case .East:
//                if ( line.point.i == nextLine.point.i - 1  && line.point.j == nextLine.point.j ) || ( line.point.i == nextLine.point.i - 1  && line.point.j == nextLine.point.j - 1 ) {
//                    // caso desenha apenas uma linha
//                    //print("1 line east.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                }
//                else if ( line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j + 1 ) || ( line.point.i == nextLine.point.i  && line.point.j == nextLine.point.j + 1 ) {
//                    //caso desenha 2 linhas
//                    //print("2 line east.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                }
//                else if ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j + 1 ) || ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j )  {
//                    //case desenha 3 linhas
//                    //print("3 line east.")
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
//                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
//                }
//                else {
//                    print("Outro caso de East.")
//                }
//            default:
//                print("There shouldn't be a line with \(line.direction) direction.")
//            }
//        }
//        CGPathCloseSubpath(path)
//        print("Shape created.\n")
//        
////        let shape = SKShapeNode(path: path)
////        shape.strokeColor = .clearColor()
////        shape.position.y = CGFloat(spriteHeight * CGFloat(numberOfVerticalTiles*levelRatio!))
////        shape.position.x =  -spriteWidth / 2
////        shape.physicsBody = SKPhysicsBody(edgeChainFromPath: path)
////        shape.physicsBody?.categoryBitMask = objectCategory
////        shape.physicsBody?.contactTestBitMask = playerCategory
////        shape.physicsBody?.collisionBitMask = playerCategory
////        shape.physicsBody?.affectedByGravity = false
////        shape.physicsBody?.restitution = 0
////        shape.yScale = -1
//        
//        let node = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeZero)
//        node.position.y = CGFloat(spriteHeight * CGFloat(numberOfVerticalTiles*levelRatio!))
//        node.position.x =  0
//        node.physicsBody = SKPhysicsBody(edgeChainFromPath: path)
//        node.physicsBody?.categoryBitMask = objectCategory
//        node.physicsBody?.contactTestBitMask = playerCategory
//        node.physicsBody?.collisionBitMask = playerCategory
//        node.physicsBody?.affectedByGravity = false
//        node.physicsBody?.restitution = 0
//        node.yScale = -1
//
//        
//        levelScene?.addChild(node)
//    }
//    
//    private func traceContourForChar(inout contourLinesArray: Array<ContourLine> ,tracedChar: Character, contourChar: Character, start: TilePoint, point: TilePoint, startingDir: Direction) {
//        
//        /*
//        Comeca com a posicao do primeiro "1", verifica o contorno até achar o proximo "1".
//        Ordem horária:  S - SW - W - NW - N - NE - E - SE
//        Quando achar o proximo "1", fazer backtrack e recomecar o algoritmo desse novo "1"
//        e ao chegar no primeiro "1" de todos, fechar o traço do contorno.
//        */
//        
//        var found = false
//        var newPoint = TilePoint(i: 0, j: 0)
//        var curPoint: TilePoint!
//        var dir: Direction = startingDir
//        var nextDir: Direction!
//        var newDir: Direction!
//        
//        for var cont = 0; cont < 8 && found == false; cont++ {
//            
//            switch (dir) {
//                
//            case .South:
//                curPoint = TilePoint(i: point.i + 1, j: point.j)
//                nextDir = .SouthWest
//                newDir = .East
//                
//                
//            case .SouthWest:
//                curPoint = TilePoint(i: point.i + 1, j: point.j - 1)
//                nextDir = .West
//                newDir = .East
//                
//            case .West:
//                curPoint = TilePoint(i: point.i , j: point.j - 1)
//                nextDir = .NorthWest
//                newDir = .South
//                
//            case .NorthWest:
//                curPoint = TilePoint(i: point.i - 1, j: point.j - 1)
//                nextDir = .North
//                newDir = .South
//                
//            case .North:
//                curPoint = TilePoint(i: point.i - 1, j: point.j)
//                nextDir = .NorthEast
//                newDir = .West
//                
//            case .NorthEast:
//                curPoint = TilePoint(i: point.i - 1, j: point.j + 1)
//                nextDir = .East
//                newDir = .West
//                
//            case .East:
//                curPoint = TilePoint(i: point.i, j: point.j + 1)
//                nextDir = .SouthEast
//                newDir = .North
//                
//            case .SouthEast:
//                curPoint = TilePoint(i: point.i + 1, j: point.j + 1)
//                nextDir = .South
//                newDir = .North
//                
//            }
//            
//            if curPoint.i < numberOfVerticalTiles*levelRatio! && curPoint.i >= 0 && curPoint.j < numberOfHorizontalTiles*levelRatio! && curPoint.j >= 0 {
//                
//                if getCharFromStringAtIndex(mooreMatrix[curPoint.i], index: curPoint.j) == tracedChar  || getCharFromStringAtIndex(mooreMatrix[curPoint.i], index: curPoint.j) == "6"{
//                    mooreMatrix[curPoint.i] = replaceCharFromStringAtIndex(mooreMatrix[curPoint.i], index: curPoint.j, char: contourChar)
//                    found = true
//                    newPoint = TilePoint(i: curPoint.i, j: curPoint.j)
//                    if dir != startingDir {
//                        dir = newDir
//                    }
//                    let line = ContourLine(point: curPoint, direction: dir)
//                    contourLinesArray.append(line)
//                }
//                else if getCharFromStringAtIndex(mooreMatrix[curPoint.i], index: curPoint.j) == contourChar && (curPoint.i != start.i || curPoint.j != start.j) {
//                    print("Found contour char.")
//                    found = true
//                    newPoint = TilePoint(i: curPoint.i, j: curPoint.j)
//                    if dir != startingDir {
//                        dir = newDir
//                    }
//                    let line = ContourLine(point: curPoint, direction: dir)
//                    contourLinesArray.append(line)
//                }
//                else {
//                    dir = nextDir
//                }
//            }
//            
//            // Descomentar para ver o resultado dos contornos
//            //printLevelMatrixLog(mooreMatrix)
//            if curPoint.i ==  start.i && curPoint.j == start.j {
//                let last = ContourLine(point: TilePoint(i: curPoint.i, j: curPoint.j), direction: newDir)
////                contourLinesArray.append(last)
//                print("Contour done.")
//                return
//            }
//        }
//        
//        if found == false {
//            let last = ContourLine(point: TilePoint(i: start.i, j: start.j), direction: .South)
////            contourLinesArray.append(last)
//            print("Contour done.")
//            return
//        }
//        
//        traceContourForChar(&contourLinesArray, tracedChar: tracedChar, contourChar: contourChar, start: start, point: newPoint, startingDir: dir)
//    }
//}
