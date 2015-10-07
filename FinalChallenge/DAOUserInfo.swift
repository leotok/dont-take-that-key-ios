//
//  DAO.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 24/09/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//

import Foundation

class DAOUserInfo {
    

    private func getPath()->String {
        
        let rootPath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let plistPath = rootPath.stringByAppendingString("/UserInfo.plist")
        let fileManager: NSFileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(plistPath) {
            
            let bundlePath: String? = NSBundle.mainBundle().pathForResource("UserInfo", ofType: "plist")
            
            if let bundle = bundlePath {
                do {
                    try fileManager.copyItemAtPath(bundle, toPath: plistPath)
                }
                catch let error as NSError {
                    print("Erro ao copiar UserInfo.plist do mainBundle para plistPath: \(error.description)")
                    return ""
                }
            }
            else {
                print("UserInfo.plist não está no mainBundle")
                return ""
            }
        }
        return plistPath
    }
    
    func save(data:UserInfo)->Bool {
    
    
        let plistPath = self.getPath()
        if(plistPath == "") {
            return false
        }

        let dictonary = ["musicON":data.musicON,"soundON":data.soundON,"samLevels":data.samLevels,"ellieLevels":data.ellieLevels,"shrinkLevels":data.shrinkLevels,"allCharacterLevels":data.allCharacterLevels]
        dictonary.writeToFile(plistPath, atomically: true)
        
        return true
    
    }
  
    func load()->UserInfo {
    
        let plistPath = self.getPath()
        
        let dataDict = NSDictionary(contentsOfFile: plistPath)
    
        if dataDict == nil || dataDict?.count == 0 {
            return UserInfo()
        }
        let data = UserInfo()
        data.musicON = dataDict?.valueForKey("musicON") as! Bool
        data.soundON = dataDict?.valueForKey("soundON") as! Bool
        data.samLevels = dataDict?.valueForKey("samLevels") as! Int
        data.ellieLevels = dataDict?.valueForKey("ellieLevels") as! Int
        data.shrinkLevels = dataDict?.valueForKey("shrinkLevels") as! Int
        data.allCharacterLevels = dataDict?.valueForKey("allCharacterLevels") as! Int
        
        return data
    }
    
} // End of Class
