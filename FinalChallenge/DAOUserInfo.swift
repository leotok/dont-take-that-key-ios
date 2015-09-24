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

//        var dictonary = ["Campo1":data.campo1,"Campo2":data.campo2]
//        dictonary.writeToFile(plistPath, atomically: true)
        
        return true
    
    }
  
    func load()->UserInfo {
    
        let plistPath = self.getPath()

        
        let dataDict = NSDictionary(contentsOfFile: "plistPath")
    
        let data = UserInfo()
        
//        data1 = dataDict?.objectForKey("Campo1")
//        data2 = dataDict?.objectForKey("Campo2")
        
        print(data)
        print(plistPath)
        print(dataDict)
        
        return data
    }
    
    
    
    
    
}