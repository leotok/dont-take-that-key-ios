//
//  CurrentCharacterSingleton.swift
//  FinalChallenge
//
//  Created by Hugo Manhães on 9/30/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation

private let currentCharacterSingleton = CurrentCharacterSingleton()

class CurrentCharacterSingleton {
    
    var currentCharacter: Character?
    
    class var sharedInstance: CurrentCharacterSingleton {
        return currentCharacterSingleton
    }
    
    init(){
        
    }
    
    func setCurrentCharacter(newCurrentCharacter: Character) {
        currentCharacterSingleton.currentCharacter = newCurrentCharacter
    }
    
}