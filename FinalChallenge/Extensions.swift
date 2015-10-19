//
//  Extensions.swift
//  FinalChallenge
//
//  Created by Thiago De Angelis on 15/10/15.
//  Copyright © 2015 Hjlmt. All rights reserved.
//                              ¯\_(ツ)_/¯
import Foundation

extension Int
{
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}