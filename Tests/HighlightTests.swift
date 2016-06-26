//
//  HighlightTests.swift
//  HighlightTests
//
//  Created by Satoshi Takano on 2016/06/26.
//  Copyright © 2016年 Satoshi Takano. All rights reserved.
//

import XCTest
@testable import Highlight

class HighlightTests: XCTestCase {
    
    func testHighlight() {
        let highlight = Highlight(string: "@boy Hello, world.")
        let result    = highlight.extract(tagPattern: "@[a-zA-Z0-9_-]*?\\s")
        XCTAssert(result.count == 2)
        XCTAssert(result[0] == .Highlighted("@boy "))
        XCTAssert(result[1] == .Normal("Hello, world."))
    }
    
    func testMultipleHighlights() {
        let highlight = Highlight(string: "@boy Good morning. @girl Good night.")
        let result    = highlight.extract(tagPattern: "@[a-zA-Z0-9_-]*?\\s")
        XCTAssert(result.count == 4)
        XCTAssert(result[0] == .Highlighted("@boy "))
        XCTAssert(result[1] == .Normal("Good morning. "))
        XCTAssert(result[2] == .Highlighted("@girl "))
        XCTAssert(result[3] == .Normal("Good night."))
    }
    
    func testEmpty() {
        let highlight = Highlight(string: "")
        let result    = highlight.extract(tagPattern: "@[a-zA-Z0-9_-]*?\\s")
        XCTAssert(result.count == 1)
        XCTAssert(result[0] == .Normal(""))
    }
    
    func testNotMatch() {
        let highlight = Highlight(string: "Hello, world.")
        let result    = highlight.extract(tagPattern: "@[a-zA-Z0-9_-]*?\\s")
        XCTAssert(result.count == 1)
        XCTAssert(result[0] == .Normal("Hello, world."))
    }
    
}
