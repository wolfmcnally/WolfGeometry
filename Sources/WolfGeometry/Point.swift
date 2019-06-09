//
//  Point.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 1/15/16.
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
import WolfCore

#if canImport(CoreGraphics)
import CoreGraphics
#endif

/// Represents a 2-dimensional point, with Double precision.
public struct Point {
    public var x: Double = 0
    public var y: Double = 0

    public init() {
        x = 0
        y = 0
    }

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

extension Point {
    /// Provides conversion from Vector.
    public init(_ vector: Vector) {
        x = vector.dx
        y = vector.dy
    }

    /// Provides conversion from polar coordinates.
    ///
    /// - Parameter center: The `Point` to be considered as the origin.
    ///
    /// - Parameter angle: The angle from the angular origin, in radians.
    ///
    /// - Parameter radius: The distance from the origin, as scalar units.
    public init(center: Point, angle theta: Double, radius: Double) {
        x = center.x + cos(theta) * radius
        y = center.y + sin(theta) * radius
    }

    public var magnitude: Double { hypot(x, y) }

    public var angle: Double { atan2(y, x) }

    public func distance(to point: Point) -> Double {
        (point - self).magnitude
    }

    public func rotated(by theta: Double, aroundCenter center: Point) -> Point {
        let v = center - self
        let v2 = v.rotated(by: theta)
        let p = center + v2
        return p
    }
}

extension Point: CustomStringConvertible {
    public var description: String {
        return("Point(\(x), \(y))")
    }
}

extension Point {
    public static let zero = Point()
    public static let infinite = Point(x: Double.infinity, y: Double.infinity)

    public init(x: Int, y: Int) {
        self.x = Double(x)
        self.y = Double(y)
    }

    public init(x: Float, y: Float) {
        self.x = Double(x)
        self.y = Double(y)
    }
}

extension Point {
    public static func min(_ p1: Point, _ p2: Point) -> Point {
        Point(x: p1.x < p2.x ? p1.x : p2.x,
                     y: p1.y < p2.y ? p1.y : p2.y)
    }

    public static func max(_ p1: Point, _ p2: Point) -> Point {
        Point(x: p1.x > p2.x ? p1.x : p2.x,
                     y: p1.y > p2.y ? p1.y : p2.y)
    }
}

extension Point {
    public static let dimensions = 2

    public subscript(dimension: Int) -> Double {
        get {
            switch dimension {
            case 0:
                return self.x
            case 1:
                return self.y
            default:
                fatalError()
            }
        }

        set {
            switch dimension {
            case 0:
                self.x = newValue
            case 1:
                self.y = newValue
            default:
                fatalError()
            }
        }
    }
}

extension Point {
    public func toNormalizedCoordinates(fromSize size: Size) -> Point {
        let nx = x.lerped(from: 0..size.width, to: -1..1)
        let ny = y.lerped(from: 0..size.height, to: -1..1)
        return Point(x: nx, y: ny)
    }

    public func fromNormalizedCoordinates(toSize size: Size) -> Point {
        let nx = x.lerped(from: -1..1, to: 0..size.width)
        let ny = y.lerped(from: -1..1, to: 0..size.height)
        return Point(x: nx, y: ny)
    }

    public func transformCoordinates(fromSize: Size, toSize: Size) -> Point {
        let nx = x.lerped(from: 0..fromSize.width, to: 0..toSize.width)
        let ny = y.lerped(from: 0..fromSize.height, to: 0..toSize.height)
        return Point(x: nx, y: ny)
    }
}

extension Point: Equatable {
    static public func == (lhs: Point, rhs: Point) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}

extension Point: Interpolable {
    public func interpolated(to other: Point, at frac: Frac) -> Point {
        Point(x: x.interpolated(to: other.x, at: frac),
                     y: y.interpolated(to: other.y, at: frac))
    }
}

public prefix func - (rhs: Point) -> Point {
    Point(x: -rhs.x, y: -rhs.y)
}

public func - (lhs: Point, rhs: Point) -> Vector {
    Vector(dx: lhs.x - rhs.x, dy: lhs.y - rhs.y)
}

public func + (lhs: Point, rhs: Vector) -> Point {
    Point(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
}

public func += (lhs: inout Point, rhs: Vector) {
    lhs = lhs + rhs
}

public func - (lhs: Point, rhs: Vector) -> Point {
    Point(x: lhs.x - rhs.dx, y: lhs.y - rhs.dy)
}

public func -= (lhs: inout Point, rhs: Vector) {
    lhs = lhs - rhs
}

public func + (lhs: Vector, rhs: Point) -> Point {
    Point(x: lhs.dx + rhs.x, y: lhs.dy + rhs.y)
}

public func - (lhs: Vector, rhs: Point) -> Point {
    Point(x: lhs.dx - rhs.x, y: lhs.dy - rhs.y)
}

public func * (lhs: Point, rhs: Double) -> Point {
    Point(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func * (lhs: Double, rhs: Point) -> Point {
    Point(x: lhs * rhs.x, y: lhs * rhs.y)
}

public func / (lhs: Point, rhs: Double) -> Point {
    Point(x: lhs.x / rhs, y: lhs.y / rhs)
}

public func + (lhs: Point, rhs: Point) -> Point {
    Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

#if canImport(CoreGraphics)
extension Point {
    public init(_ p: CGPoint) {
        self.init(x: Double(p.x), y: Double(p.y))
    }
}

extension CGPoint {
    public init(_ p: Point) {
        self.init(x: CGFloat(p.x), y: CGFloat(p.y))
    }
}
#endif

extension Point : Codable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        x = try container.decode(Double.self)
        y = try container.decode(Double.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(x)
        try container.encode(y)
    }
}
