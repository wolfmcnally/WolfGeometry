//
//  IntPoint.swift
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

public struct IntPoint {
    public var x: Int
    public var y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    public static let zero = IntPoint(x: 0, y: 0)
}

extension IntPoint {
    public var point: Point {
        return Point(x: Double(x), y: Double(y))
    }
}

public func + (lhs: IntPoint, rhs: IntOffset) -> IntPoint {
    return IntPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
}

public func += (lhs: inout IntPoint, rhs: IntOffset) {
    lhs = lhs + rhs
}

extension IntPoint: CustomStringConvertible {
    public var description: String {
        get {
            return "IntPoint(x:\(x) y:\(y))"
        }
    }
}

extension IntPoint: Equatable {
    public static func == (lhs: IntPoint, rhs: IntPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

extension IntPoint: Codable {
}
