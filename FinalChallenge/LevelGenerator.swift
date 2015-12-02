//
//  LevelGenerator.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit
import Darwin

enum LevelTheme {
    
    case Sam
    case Shrink
    case Ellie
    case AllChar
    
}

enum TileType {
    
    case Floor
    case Wall
    case Empty
}

enum Direction {
    case NorthWest
    case North
    case NorthEast
    case East
    case SouthEast
    case South
    case SouthWest
    case West
}

struct TilePoint {
    var i: Int
    var j: Int
}

struct ContourLine {
    var point: TilePoint
    var direction: Direction
}

class LevelGenerator {
    
    private var levelMatrix: Array<String>!
    private var mooreMatrix: Array<String>!
    private var shapesArray = Array<Array<ContourLine>>()
    private var levelScene: SKScene!
    
    var levelTheme: LevelTheme!
    var levelIndex = 0
    var levelRatio: Int = 1

    var numberOfControlTiles = 0
    let numberOfVerticalTiles = 13
    let numberOfHorizontalTiles = 24
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
        mooreMatrix = levelMatrix
        
        let alphabet = "abcdefghijklmnopqrstuvwxyz"
        var startingChar = getCharFromStringAtIndex(alphabet, index: 0)
        var line = defineStartingPoint("1",contourChar: "a")

        for var i = 1; i < 26 && (line.point.i >= 0 && line.point.j >= 0) ; i++ {
            
            var array = Array<ContourLine>()
            array.append(line)
            if line.point.i >= 0 && line.point.j >= 0 {
                traceContourForChar(&array,tracedChar: "1", contourChar: startingChar, start: line.point, point: line.point, startingDir: line.direction)
                shapesArray.append(array)
                startingChar = getCharFromStringAtIndex(alphabet, index: i)
                line = defineStartingPoint("1",contourChar: startingChar)
            }
        }
        
        for shape in shapesArray {
            createNodeForContourLines(shape)
        }
        
        addCorrespondingBackground()
        generateNodes()
        addCharacterToGameScene()
        
        self.levelScene = nil
        self.levelMatrix = nil
        
        
        print("Generated in \(NSDate().timeIntervalSinceDate(time)) seconds.")
        return true
    }
    
    func getLevelSize()->CGSize{
        let size = CGSize(width: CGFloat(self.numberOfHorizontalTiles) * CGFloat(levelRatio) * spriteHeight, height: CGFloat(self.numberOfVerticalTiles) * CGFloat(levelRatio) * spriteHeight)
        return size
    }
    
    // FUNCOES PARA MANUPULAR MELHOR STRINGS
    
    private func getCharFromStringAtIndex(string: String, index: Int) ->  Character {
        
        let i = string.startIndex.advancedBy(index)
        return string[i]
    }
    
    private func replaceCharFromStringAtIndex(string: String, index: Int, char: Character)-> String{
        
        var newString = string as NSString
        
        newString = (string as NSString).stringByReplacingCharactersInRange(NSMakeRange(index, 1), withString: String(char))
        
        return newString as String
    }
    
    // FUNCAO QUE DEFINE O PONTO DE INICIO DO CONTORNO
    
    private func defineStartingPoint(tracedChar: Character, contourChar: Character) -> ContourLine {
        
        for i in 0...(numberOfVerticalTiles * levelRatio - 1) {
            
            let string: String = mooreMatrix[i]
            
            for j in 1...(numberOfHorizontalTiles*levelRatio - 1) {
                
                let char: Character = getCharFromStringAtIndex(string, index: j)
                
                
                if  char == tracedChar || char == "6"{
                    let northCase = i > 0 && getCharFromStringAtIndex(mooreMatrix[i-1], index: j) == "0"
                    let southCase = i < numberOfVerticalTiles * levelRatio - 1 && getCharFromStringAtIndex(mooreMatrix[i+1], index: j) == "0"
                    let eastCase = j < numberOfHorizontalTiles * levelRatio - 1 && getCharFromStringAtIndex(mooreMatrix[i], index: j+1) == "0"
                    let westCase = j > 0 && getCharFromStringAtIndex(mooreMatrix[i], index: j-1) == "0"
                    
                    if eastCase || westCase || southCase || northCase {
                        //print("Found! \(char)")
                        mooreMatrix[i] = replaceCharFromStringAtIndex(mooreMatrix[i], index: j, char: contourChar)
                        let start = TilePoint(i: i, j: j)
                        let line = ContourLine(point: start, direction: .South)
                        return line
                    }
                }
            }
        }
        print("Dint find any starting point.")
        let noLine = ContourLine(point: TilePoint(i: -1, j: -1), direction: .South)
        return noLine
    }

    
    // ADICIONA O PERSONAGEM PARA O CAPITULO CORRETO
    
    private func addCharacterToGameScene() {
    
        let player = Sam()
        player.setDelegate(levelScene as! GenericGameScene)
        (levelScene as! GenericGameScene).selectedPlayer = player
        (levelScene as! GenericGameScene).selectedPlayer.position = CGPointMake(50, 200)
        (levelScene as! GenericGameScene).addChild((levelScene as! GenericGameScene).selectedPlayer)
    
    }
    
    // ADICIONA O BACKGROUND PARA O CAPITULO CORRETO
    
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
    
    // FUNCAO QUE FAZ A LEITURA DO TXT E GUARDA NA MATRIZ
    
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
    
    // FUNCAO PARA DEFINIR O CAPITULO/TEMA
    
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
    
    // FUNCAO DE DEBUG DA MATRIZ NO LOG

    private func printLevelMatrixLog(array: Array<String>) {
        
        for i in 0...(self.numberOfVerticalTiles * levelRatio - 1) {
            
            print(String(format: "%02d %@", i, array[i]))
        }
        print("\n")
    }
    
    // FUNCOES DO ALGOTIMO DE MOORE
    
    private func createNodeForContourLines(contourLinesArray: Array<ContourLine>) {
        
        let path = CGPathCreateMutable()
        
        let initialPoint = contourLinesArray.first?.point
        if contourLinesArray.count == 1 {
            CGPathMoveToPoint(path, nil, CGFloat(initialPoint!.j ) * spriteHeight, CGFloat(initialPoint!.i + 1) * spriteHeight)
        }
        else {
            CGPathMoveToPoint(path, nil, CGFloat(initialPoint!.j + 1) * spriteHeight, CGFloat(initialPoint!.i + 1) * spriteHeight)
        }
        
        for k in 0...contourLinesArray.count - 1 {
            
            let line = contourLinesArray[k]
            var nextLine: ContourLine!
            if k == contourLinesArray.count - 1 {
                nextLine = contourLinesArray.first
            }
            else {
                nextLine = contourLinesArray[k + 1]
            }
            
            switch (line.direction) {
            case .North:
                if (line.point.i == nextLine.point.i  && line.point.j == nextLine.point.j - 1) || (line.point.i == nextLine.point.i + 1  && line.point.j == nextLine.point.j - 1 ) {
                    // caso desenha apenas uma linha
                    //print("1 line north.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i) * spriteHeight)
                }
                else if (line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j - 1 ) || ( line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j ) {
                    //caso desenha 2 linhas
                    //print("2 line north.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                }
                else if ( line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j + 1 ) || ( line.point.i == nextLine.point.i  && line.point.j == nextLine.point.j + 1 ) {
                    //case desenha 3 linhas
                    //print("3 line north.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                }
                else {
                    print("Outro caso de North.")
                }
                
            case .South:
                if ( line.point.i == nextLine.point.i  && line.point.j == nextLine.point.j + 1 ) || ( line.point.i == nextLine.point.i - 1  && line.point.j == nextLine.point.j + 1 )  {
                    // caso desenha apenas uma linha
                    //print("1 line south.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                }
                else if ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j + 1 ) ||  ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j ) {
                    //caso desenha 2 linhas
                    //print("2 line south.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i) * spriteHeight)
                }
                else if ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j - 1 ) || ( line.point.i == nextLine.point.i && line.point.j == nextLine.point.j - 1 ) {
                    //case desenha 3 linhas
                    //print("3 line south.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
                }
                else {
                    //print("4 lines south.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1 ) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i + 1 ) * spriteHeight)
                }
                
            case .West:
                if (line.point.i == nextLine.point.i + 1  && line.point.j == nextLine.point.j ) || ( line.point.i == nextLine.point.i + 1  && line.point.j == nextLine.point.j + 1 ) {
                    // caso desenha apenas uma linha
                    //print("1 line west.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
                }
                else if ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j - 1 ) || ( line.point.i == nextLine.point.i && line.point.j == nextLine.point.j - 1 ) {
                    //caso desenha 2 linhas
                    //print("2 line west.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
                }
                else if ( line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j - 1 ) || ( line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j ) {
                    //case desenha 3 linhas
                    //print("3 line west.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                }
                else {
                    print("Outro caso de West.")
                }
                
            case .East:
                if ( line.point.i == nextLine.point.i - 1  && line.point.j == nextLine.point.j ) || ( line.point.i == nextLine.point.i - 1  && line.point.j == nextLine.point.j - 1 ) {
                    // caso desenha apenas uma linha
                    //print("1 line east.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                }
                else if ( line.point.i == nextLine.point.i - 1 && line.point.j == nextLine.point.j + 1 ) || ( line.point.i == nextLine.point.i  && line.point.j == nextLine.point.j + 1 ) {
                    //caso desenha 2 linhas
                    //print("2 line east.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                }
                else if ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j + 1 ) || ( line.point.i == nextLine.point.i + 1 && line.point.j == nextLine.point.j )  {
                    //case desenha 3 linhas
                    //print("3 line east.")
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j + 1) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i + 1) * spriteHeight)
                    CGPathAddLineToPoint(path, nil, CGFloat(line.point.j ) * spriteHeight, CGFloat(line.point.i ) * spriteHeight)
                }
                else {
                    print("Outro caso de East.")
                }
            default:
                print("There shouldn't be a line with \(line.direction) direction.")
            }
        }
        CGPathCloseSubpath(path)
        print("Shape created.\n")
        
        //        let shape = SKShapeNode(path: path)
        //        shape.strokeColor = .clearColor()
        //        shape.position.y = CGFloat(spriteHeight * CGFloat(numberOfVerticalTiles*levelRatio!))
        //        shape.position.x =  -spriteWidth / 2
        //        shape.physicsBody = SKPhysicsBody(edgeChainFromPath: path)
        //        shape.physicsBody?.categoryBitMask = objectCategory
        //        shape.physicsBody?.contactTestBitMask = playerCategory
        //        shape.physicsBody?.collisionBitMask = playerCategory
        //        shape.physicsBody?.affectedByGravity = false
        //        shape.physicsBody?.restitution = 0
        //        shape.yScale = -1
        
        let node = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeZero)
        node.position.y = CGFloat(spriteHeight * CGFloat(numberOfVerticalTiles * levelRatio ))
        node.position.x =  0
        node.physicsBody = SKPhysicsBody(edgeChainFromPath: path)
        node.physicsBody?.categoryBitMask = objectCategory
        node.physicsBody?.contactTestBitMask = playerCategory
        node.physicsBody?.collisionBitMask = playerCategory
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.restitution = 0
        node.yScale = -1
        
        
        levelScene?.addChild(node)
    }
    
    private func traceContourForChar(inout contourLinesArray: Array<ContourLine> ,tracedChar: Character, contourChar: Character, start: TilePoint, point: TilePoint, startingDir: Direction) {
        
        /*
        Comeca com a posicao do primeiro "1", verifica o contorno até achar o proximo "1".
        Ordem horária:  S - SW - W - NW - N - NE - E - SE
        Quando achar o proximo "1", fazer backtrack e recomecar o algoritmo desse novo "1"
        e ao chegar no primeiro "1" de todos, fechar o traço do contorno.
        */
        
        var found = false
        var newPoint = TilePoint(i: 0, j: 0)
        var curPoint: TilePoint!
        var dir: Direction = startingDir
        var nextDir: Direction!
        var newDir: Direction!
        
        for var cont = 0; cont < 8 && found == false; cont++ {
            
            switch (dir) {
                
            case .South:
                curPoint = TilePoint(i: point.i + 1, j: point.j)
                nextDir = .SouthWest
                newDir = .East
                
                
            case .SouthWest:
                curPoint = TilePoint(i: point.i + 1, j: point.j - 1)
                nextDir = .West
                newDir = .East
                
            case .West:
                curPoint = TilePoint(i: point.i , j: point.j - 1)
                nextDir = .NorthWest
                newDir = .South
                
            case .NorthWest:
                curPoint = TilePoint(i: point.i - 1, j: point.j - 1)
                nextDir = .North
                newDir = .South
                
            case .North:
                curPoint = TilePoint(i: point.i - 1, j: point.j)
                nextDir = .NorthEast
                newDir = .West
                
            case .NorthEast:
                curPoint = TilePoint(i: point.i - 1, j: point.j + 1)
                nextDir = .East
                newDir = .West
                
            case .East:
                curPoint = TilePoint(i: point.i, j: point.j + 1)
                nextDir = .SouthEast
                newDir = .North
                
            case .SouthEast:
                curPoint = TilePoint(i: point.i + 1, j: point.j + 1)
                nextDir = .South
                newDir = .North
                
            }
            
            if curPoint.i < numberOfVerticalTiles * levelRatio && curPoint.i >= 0 && curPoint.j < numberOfHorizontalTiles * levelRatio && curPoint.j >= 0 {
                
                if getCharFromStringAtIndex(mooreMatrix[curPoint.i], index: curPoint.j) == tracedChar  || getCharFromStringAtIndex(mooreMatrix[curPoint.i], index: curPoint.j) == "6"{
                    mooreMatrix[curPoint.i] = replaceCharFromStringAtIndex(mooreMatrix[curPoint.i], index: curPoint.j, char: contourChar)
                    found = true
                    newPoint = TilePoint(i: curPoint.i, j: curPoint.j)
                    if dir != startingDir {
                        dir = newDir
                    }
                    let line = ContourLine(point: curPoint, direction: dir)
                    contourLinesArray.append(line)
                }
                else if getCharFromStringAtIndex(mooreMatrix[curPoint.i], index: curPoint.j) == contourChar && (curPoint.i != start.i || curPoint.j != start.j) {
                    //print("Found contour char.")
                    found = true
                    newPoint = TilePoint(i: curPoint.i, j: curPoint.j)
                    if dir != startingDir {
                        dir = newDir
                    }
                    let line = ContourLine(point: curPoint, direction: dir)
                    contourLinesArray.append(line)
                }
                else {
                    dir = nextDir
                }
            }
            
            // Descomentar para ver o resultado dos contornos
            //printLevelMatrixLog(mooreMatrix)
            if curPoint.i ==  start.i && curPoint.j == start.j {
        
                print("Contour done.")
                return
            }
        }
        
        if found == false {
            
            return
        }
        
        traceContourForChar(&contourLinesArray, tracedChar: tracedChar, contourChar: contourChar, start: start, point: newPoint, startingDir: dir)
    }
    
    // generateNodes: FUNCAO QUE ADIOCIONA OS NODES NA TELA PARA SUAS POSICOES
    
    private func generateNodes() {
    
        
        for i in 0...(levelRatio * self.numberOfVerticalTiles - 1)
        {
            let string = levelMatrix[i]
            var index = string.startIndex
            for j in 0...(levelRatio * self.numberOfHorizontalTiles - 1)
            {
                if let tile: SKSpriteNode = getNodeType( string[index] )
                {
                    tile.position = CGPointMake( spriteHeight/2 +  spriteHeight * CGFloat( (j) )  , (spriteHeight / 2) + spriteHeight * CGFloat( (levelRatio * numberOfVerticalTiles - i - 1) ) )
                    (levelScene as! GenericGameScene).pausableLayer.addChild(tile)
                }
                index = index.advancedBy(1)
            }
        }
    }
    
    // getNodeType: FUNÇÃO QUE GERA NODES DA FASE NA TELA, ESSES NODES NAO TEM PHYSIC BODY
    
    private func getNodeType(nodeType: Character)-> SKSpriteNode? {
        
        var tile: SKSpriteNode!
        
        switch (nodeType) {
            
            case "1":
            
                tile = StaticObject(sprite: SKTexture(imageNamed: "Ground_1"))
                tile.physicsBody = nil
                tile.size = CGSizeMake(spriteHeight, spriteHeight)
            
            case "2":
            
                tile = KeyNode()
                (levelScene as! GenericGameScene).pausableObjectsArray.append(tile)
            
            case "3":
            
                tile = CrateNode()
                (levelScene as! GenericGameScene).pausableObjectsArray.append(tile)
            
            case "4":
            
                tile = DoorNode()
            
            case "5":
            
                tile = SpikeNode()
            
            case "6":
        
                tile = StaticObject(sprite: SKTexture(imageNamed: "groundTop1"))
                tile.size = CGSizeMake(spriteHeight, spriteHeight)
                tile.physicsBody = nil
            
            case "7":
            
                tile =  ControlTile.createControlTile()
                numberOfControlTiles++
                (tile as! ControlTile).number = numberOfControlTiles
            
            case "8":
            
                tile = ClockHandNode()
                (levelScene as! GenericGameScene).pausableObjectsArray.append(tile)
            
            case "9":
            
                tile = AmpulhetaNode()
                (levelScene as! GenericGameScene).pausableObjectsArray.append(tile)
            
            case "0":
                
                break;
            
            default:
                print("Node type inside .txt doesnt exists.")
        }
        
        return tile
    }
}