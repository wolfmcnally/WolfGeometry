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

    public var width: Int { size.width }
    public var height: Int { size.height }

    public var min: IntPoint { origin }
    public var max: IntPoint { IntPoint(x: maxX, y: maxY) }
    public var mid: IntPoint { IntPoint(x: midX, y: midY) }

    public var minX: Int { origin.x }
    public var minY: Int { origin.y }

    public var maxX: Int { origin.x + size.width - 1 }
    public var maxY: Int { origin.y + size.height - 1 }

    public var midX: Int { origin.x + size.width / 2 }
    public var midY: Int { origin.y + size.height / 2 }

    public var rangeX: CountableClosedRange<Int> { minX ... maxX }
    public var rangeY: CountableClosedRange<Int> { minY ... maxY }

    public func randomX() -> Int { origin.x + size.randomX() }
    public func randomY() -> Int { origin.y + size.randomY() }
    public func randomPoint() -> IntPoint { IntPoint(x: randomX(), y: randomY()) }

    public func isValidPoint(_ p: IntPoint) -> Bool {
        p.x >= minX && p.y >= minY && p.x <= maxX && p.y <= maxY
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
        lhs.origin == rhs.origin && lhs.size == rhs.size
    }
}

extension IntRect: Codable {
}
