//
//  LevelGenerator.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation
import SpriteKit

protocol GeneratorDelegate {

    func addNodeToScene(node:SKNode)


}

class LevelGenerator {
    
    var delegate:GeneratorDelegate?
    
    
    func loadLevel(level:Int)->Bool {
    
    
        
        
      //self.delegate?.addNode(....)
    
        return true
    }
    
    
    
}