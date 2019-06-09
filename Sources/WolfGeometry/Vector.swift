//
//  Vector.swift
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

#if canImport(CoreGraphics)
    import CoreGraphics
#elseif canImport(Glibc)
    import Glibc
#endif

import Foundation
import WolfCore

public struct Vector {
    public var dx: Double = 0
    public var dy: Double = 0

    public init() {
        dx = 0
        dy = 0
    }

    public init(dx: Double, dy: Double) {
        self.dx = dx
        self.dy = dy
    }

    public init(angle theta: Double, magnitude: Double) {
        dx = cos(theta) * magnitude
        dy = sin(theta) * magnitude
    }
}

extension Vector: CustomStringConvertible {
    public var description: String {
        return("Vector(\(dx), \(dy))")
    }
}

extension Vector {
    public static let zero = Vector()

    public init(dx: Int, dy: Int) {
        self.dx = Double(dx)
        self.dy = Double(dy)
    }

    public init(dx: Float, dy: Float) {
        self.dx = Double(dx)
        self.dy = Double(dy)
    }
}

extension Vector {
    public init(_ point1: Point, _ point2: Point) {
        dx = point2.x - point1.x
        dy = point2.y - point1.y
    }

    public init(_ point: Point) {
        dx = point.x
        dy = point.y
    }

    public init(_ size: Size) {
        dx = size.width
        dy = size.height
    }

    public var magnitude: Double { hypot(dx, dy) }

    public var angle: Double { atan2(dy, dx) }

    public var normalized: Vector {
        let m = magnitude
        assert(m > 0.0)
        return self / m
    }

    public mutating func normalize() {
        self = self.normalized
    }

    public func rotated(by theta: Double) -> Vector {
        let sinTheta = sin(theta)
        let cosTheta = cos(theta)
        return Vector(dx: dx * cosTheta - dy * sinTheta, dy: dx * sinTheta + dy * cosTheta)
    }

    public mutating func rotate(byAngle theta: Double) {
        self = rotated(by: theta)
    }

    public var swapped: Vector {
        Vector(dx: dy, dy: dx)
    }

    public mutating func swap() {
        self = swapped
    }

    public static var unit = Vector(dx: 1, dy: 0)
}

extension Vector {
    public static func min(_ v1: Vector, _ v2: Vector) -> Vector {
        Vector(dx: v1.dx < v2.dx ? v1.dx : v2.dx,
                     dy: v1.dy < v2.dy ? v1.dy : v2.dy)
    }

    public static func max(_ v1: Vector, _ v2: Vector) -> Vector {
        Vector(dx: v1.dx > v2.dx ? v1.dx : v2.dx,
                     dy: v1.dy > v2.dy ? v1.dy : v2.dy)
    }
}

extension Vector {
    public static let dimensions = 2

    public subscript(dimension: Int) -> Double {
        get {
            switch dimension {
            case 0:
                return self.dx
            case 1:
                return self.dy
            default:
                fatalError()
            }
        }

        set {
            switch dimension {
            case 0:
                self.dx = newValue
            case 1:
                self.dy = newValue
            default:
                fatalError()
            }
        }
    }
}

extension Vector: Equatable {
}

public func == (lhs: Vector, rhs: Vector) -> Bool {
    lhs.dx == rhs.dx && lhs.dy == rhs.dy
}

public prefix func - (v: Vector) -> Vector {
    Vector(dx: -v.dx, dy: -v.dy)
}

public func + (lhs: Vector, rhs: Vector) -> Vector {
    Vector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
}

public func - (lhs: Vector, rhs: Vector) -> Vector {
    Vector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
}

public func / (lhs: Vector, rhs: Double) -> Vector {
    Vector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
}

public func / (lhs: Vector, rhs: Vector) -> Vector {
    Vector(dx: lhs.dx / rhs.dx, dy: lhs.dy / rhs.dy)
}

public func * (lhs: Vector, rhs: Double) -> Vector {
    Vector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
}

public func * (lhs: Double, rhs: Vector) -> Vector {
    Vector(dx: lhs * rhs.dx, dy: lhs * rhs.dy)
}

public func * (lhs: Vector, rhs: Vector) -> Vector {
    Vector(dx: lhs.dx * rhs.dx, dy: lhs.dy * rhs.dy)
}

public func dot(_ v1: Vector, _ v2: Vector) -> Double {
    v1.dx * v2.dx + v1.dy * v2.dy
}

public func cross(_ v1: Vector, _ v2: Vector) -> Double {
    v1.dx * v2.dy - v1.dy * v2.dx
}

extension Vector: Interpolable {
    public func interpolated(to other: Vector, at frac: Frac) -> Vector {
        Vector(dx: dx.interpolated(to: other.dx, at: frac),
                        dy: dy.interpolated(to: other.dy, at: frac))
    }
}

#if canImport(CoreGraphics)
extension Vector {
    public init(v: CGVector) {
        self.init(dx: Double(v.dx), dy: Double(v.dy))
    }
}

extension CGVector {
    public init(v: Vector) {
        self.init(dx: CGFloat(v.dx), dy: CGFloat(v.dy))
    }
}
#endif

extension Vector : Codable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        dx = try container.decode(Double.self)
        dy = try container.decode(Double.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(dx)
        try container.encode(dy)
    }
}
