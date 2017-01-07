//
//  NumberExtension.swift
//  BFKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 - 2017 Fabrizio Brancati. All rights reserved.
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

import Foundation
import Dispatch

// MARK: - Global functions

/// Degrees to radians conversion.
///
/// - Parameter degrees: Degrees to be converted.
/// - Returns: Returns the convertion result.
public func degreesToRadians(_ degrees: Float) -> Float {
    return Float(Double(degrees) * M_PI / 180)
}

/// Radians to degrees conversion.
///
/// - Parameter radians: Radians to be converted.
/// - Returns: Returns the convertion result.
public func radiansToDegrees(_ radians: Float) -> Float {
    return Float(Double(radians) * 180 / M_PI)
}

/// Create a random integer between the given range.
///
/// - Parameters:
///   - minValue: Mininum random value.
///   - maxValue: Maxinum random value.
/// - Returns: Returns the created random integer.
public func randomInt(min minValue: Int, max maxValue: Int) -> Int {
    return minValue + Int(randomFloat() * Float(maxValue - minValue))
}

/// Create a random integer between the given range.
/// Example: randomInt(-500...100).
///
/// - Parameter range: Range random value.
/// - Returns: Returns the created random integer.
public func randomInt(range: ClosedRange<Int>) -> Int {
    var offset = 0
    
    if range.lowerBound < 0 {
        offset = abs(range.lowerBound)
    }
    
    let min = UInt32(range.lowerBound + offset)
    let max = UInt32(range.upperBound + offset)
    
    #if os(Linux)
        return Int(Int(min) + Int(Int.random()) % Int(max - min)) - offset
    #else
        return Int(min + arc4random_uniform(max - min)) - offset
    #endif
}

/// Create a random float.
///
/// - Returns: Returns the created random float.
public func randomFloat() -> Float {
    #if os(Linux)
        return Float.random()
    #else
        return Float(arc4random()) / Float(UINT32_MAX)
    #endif
}

/// Create a random float between the given range.
///
/// - Parameters:
///   - minValue: Mininum random value.
///   - maxValue: Maxinum random value.
/// - Returns: Returns the created random float.
public func randomFloat(min minValue: Float, max maxValue: Float) -> Float {
    return randomFloat() * abs(minValue - maxValue) + min(minValue, maxValue)
}

// MARK: - Extensions

#if os(Linux)
    /// Produces great cryptographically random numbers.
    private struct Randomizer {
        /// /dev/urandom file.
        static let file = fopen("/dev/urandom", "r")!
        /// Random queue.
        static let queue = DispatchQueue(label: "random")
        
        /// Get a random number of a given capacity.
        ///
        /// - Parameter count: Byte count.
        /// - Returns: Return the random number.
        static func get(count: Int) -> [Int8] {
            let capacity = count + 1
            var data = UnsafeMutablePointer<Int8>.allocate(capacity: capacity)
            defer {
                data.deallocate(capacity: capacity)
            }
            _ = queue.sync {
                fgets(data, Int32(capacity), file)
            }
            return Array(UnsafeMutableBufferPointer(start: data, count: count))
        }
    }
    
    /// This extension adds some useful function to SignedInteger.
    public extension SignedInteger {
        /// Creates a random integer number.
        ///
        /// - Returns: Returns the creates a random integer number.
        static func random() -> Self {
            let numbers = Randomizer.get(count: MemoryLayout<Self>.size)
            return numbers.withUnsafeBufferPointer { bufferPointer in
                return bufferPointer.baseAddress!.withMemoryRebound(to: Self.self, capacity: 1) {
                    return $0.pointee
                }
            }
        }
    }
    
    /// This extension adds some useful function to FloatingPoint.
    public extension FloatingPoint {
        /// Creates a random floating number.
        ///
        /// - Returns: Returns the creates a random floating number.
        static func random() -> Self {
            return Self(Int.random() / Int(UINT32_MAX))
        }
    }
#endif

/// This extesion adds some useful functions to Double.
public extension Double {
    /// Gets the individual numbers, and puts them into an array. All negative numbers will start with 0.
    var array: [Int] {
        return description.characters.map { Int(String($0)) ?? 0 }
    }
}

/// This extesion adds some useful functions to Float.
public extension Float {
    /// Gets the individual numbers, and puts them into an array. All negative numbers will start with 0.
    var array: [Int] {
        return description.characters.map { Int(String($0)) ?? 0 }
    }
}

/// This extesion adds some useful functions to Int.
public extension Int {
    /// Gets the individual numbers, and puts them into an array. All negative numbers will start with 0.
    var array: [Int] {
        return description.characters.map { Int(String($0)) ?? 0 }
    }
}
