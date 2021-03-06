//
//  UIFontExtensionTests.swift
//  BFKit-Swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 - 2018 Fabrizio Brancati.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

@testable import BFKit
import Foundation
import UIKit
import XCTest

internal class UIFontExtensionTests: XCTestCase {
    internal func testLightFont() {
        UIFont.lightFont = UIFont(fontName: .helvetica, size: 20)
        
        XCTAssertEqual(UIFont.lightFont?.fontName, FontName.helvetica.rawValue)
    }
    
    internal func testRegularFont() {
        UIFont.regularFont = UIFont(fontName: .helvetica, size: 20)
        
        XCTAssertEqual(UIFont.regularFont?.fontName, FontName.helvetica.rawValue)
    }
    
    internal func testBoldFont() {
        UIFont.boldFont = UIFont(fontName: .helvetica, size: 20)
        
        XCTAssertEqual(UIFont.boldFont?.fontName, FontName.helvetica.rawValue)
    }
    
    internal func testInitFontNameSize() {
        let font = UIFont(fontName: .helveticaNeue, size: 20)
        
        XCTAssertEqual(font?.fontName, FontName.helveticaNeue.rawValue)
    }
    
    internal func testAllFonts() {
        let fonts = UIFont.allFonts()
        
        XCTAssertNotNil(fonts)
        XCTAssertFalse(fonts.isEmpty)
    }
    
    internal func testCalculateHeightWidthFontText() {
        let height = UIFont.calculateHeight(width: 320, font: UIFont(fontName: .helvetica, size: 12)!, text: "This is a test\nOn multiple\nLines.\n\nBye.") // swiftlint:disable:this force_unwrapping
        
        XCTAssertGreaterThan(height, 0)
    }
    
    internal func testCalculateHeightWidthFontSizeText() {
        let height = UIFont.calculateHeight(width: 320, font: .helvetica, fontSize: 12, text: "This is a test\nOn multiple\nLines.\n\nBye.")
        
        XCTAssertGreaterThan(height, 0)
    }
    
    internal func testFontsNameFamily() {
        let fonts = UIFont.fontNames(for: .helvetica)
        
        XCTAssertFalse(fonts.isEmpty)
    }
}
