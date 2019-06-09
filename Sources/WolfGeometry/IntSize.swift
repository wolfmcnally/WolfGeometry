//
//  IntSize.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 1/20/16.
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
import CoreGraphics

public struct IntSize {
    public var width: Int
    public var height: Int

    public init(width: Int = 0, height: Int = 0) {
        self.width = width
        self.height = height
    }

    public func randomX() -> Int {
        return Int.random(in: 0 ..< width)
    }

    public func randomY() -> Int {
        return Int.random(in: 0 ..< height)
    }

    public func randomPoint() -> Point {
        return Point(x: randomX(), y: randomY())
    }

    public static let zero = IntSize()

    public var bounds: IntRect {
        return IntRect(origin: .zero, size: self)
    }

    public var aspect: CGFloat {
        return CGFloat(width) / CGFloat(height)
    }
}

extension IntSize: CustomStringConvertible {
    public var description: String {
        get {
            return "IntSize(width:\(width) height:\(height))"
        }
    }
}

extension IntSize: Equatable {
    public static func == (lhs: IntSize, rhs: IntSize) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
}

extension IntSize: Codable {
}
