//
//  Highlight.swift
//  Highlight
//
//  Created by Satoshi Takano on 2016/06/26.
//  Copyright © 2016年 Satoshi Takano. All rights reserved.
//

import Foundation

public struct Highlight {
    public enum WordType {
        case Normal(String)
        case Highlighted(String)
    }
    
    private let string: String
    
    public init(string: String) {
        self.string = string
    }
    
    private func stringInRange(range: Range<Int>) -> String {
        let start = string.startIndex.advancedBy(range.startIndex)
        let end   = start.advancedBy(range.endIndex - range.startIndex)
        return string[Range(start ..< end)]
    }
    
    public func extract(tagPattern tagPattern: String) -> [WordType] {
        let regEx       = try! NSRegularExpression(pattern: tagPattern, options: NSRegularExpressionOptions())
        let stringCount = string.characters.count
        let matches     = regEx.matchesInString(string, options: NSMatchingOptions(), range: NSMakeRange(0, stringCount))
        
        if matches.isEmpty {
            return [WordType.Normal(string)]
        }
        
        let ranges = matches.map { (res) in
            (startIndex: res.range.location, endIndex: res.range.location + res.range.length - 1)
        }
        var cursor  = 0
        var strings = [WordType]()
        for (i, r) in ranges.enumerate() {
            if r.startIndex > 0 {
                strings.append(.Normal(stringInRange(cursor..<r.startIndex)))
            }
            
            strings.append(.Highlighted(stringInRange(r.startIndex...r.endIndex)))
            if (i == ranges.count - 1 && r.endIndex < stringCount - 1) {
                strings.append(.Normal(stringInRange(r.endIndex + 1..<stringCount)))
            }
            cursor = r.endIndex + 1
        }
        
        return strings
    }
}