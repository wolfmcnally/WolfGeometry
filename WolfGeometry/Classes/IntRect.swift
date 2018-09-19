//
//  IntRect.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 9/16/18.
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

public struct IntRect {
    public var origin: IntPoint
    public var size: IntSize

    public init(origin: IntPoint = .zero, size: IntSize = .zero) {
        self.origin = origin
        self.size = size
    }

    public var width: Int { return size.width }
    public var height: Int { return size.height }

    public var min: IntPoint { return origin }
    public var max: IntPoint { return IntPoint(x: maxX, y: maxY) }
    public var mid: IntPoint { return IntPoint(x: midX, y: midY) }

    public var minX: Int { return origin.x }
    public var minY: Int { return origin.y }

    public var maxX: Int { return origin.x + size.width - 1 }
    public var maxY: Int { return origin.y + size.height - 1 }

    public var midX: Int { return origin.x + size.width / 2 }
    public var midY: Int { return origin.y + size.height / 2 }

    public var rangeX: CountableClosedRange<Int> { return minX ... maxX }
    public var rangeY: CountableClosedRange<Int> { return minY ... maxY }

    public func randomX() -> Int { return origin.x + size.randomX() }
    public func randomY() -> Int { return origin.y + size.randomY() }
    public func randomPoint() -> IntPoint { return IntPoint(x: randomX(), y: randomY()) }

    public func isValidPoint(_ p: IntPoint) -> Bool {
        return p.x >= minX && p.y >= minY && p.x <= maxX && p.y <= maxY
    }

    public func checkPoint(_ point: IntPoint) {
        assert(point.x >= minX, "x must be >= \(minX)")
        assert(point.y >= minY, "y must be >= \(minY)")
        assert(point.x <= maxX, "x must be <= \(maxX)")
        assert(point.y <= maxY, "y must be <= \(maxY)")
    }
}

extension IntRect: CustomStringConvertible {
    public var description: String {
        return("IntRect(\(origin), \(size))")
    }
}

extension IntRect {
    public static let zero = IntRect()
}

extension IntRect: Equatable {
    public static func == (lhs: IntRect, rhs: IntRect) -> Bool {
        return lhs.origin == rhs.origin && lhs.size == rhs.size
    }
}

extension IntRect: Codable {
}
