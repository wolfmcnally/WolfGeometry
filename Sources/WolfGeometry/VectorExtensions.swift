//
//  VectorExtensions.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 7/4/15.
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

import CoreGraphics
import WolfCore

extension CGVector {
    public init(angle theta: CGFloat, magnitude: CGFloat) {
        self.init(dx: cos(theta) * magnitude, dy: sin(theta) * magnitude)
    }

    public init(_ point1: CGPoint, _ point2: CGPoint) {
        self.init(dx: point2.x - point1.x, dy: point2.y - point1.y)
    }

    public init(point: CGPoint) {
        self.init(dx: point.x, dy: point.y)
    }

    public init(size: CGSize) {
        self.init(dx: size.width, dy: size.height)
    }

    public var magnitude: CGFloat {
        return hypot(dx, dy)
    }

    public var angle: CGFloat {
        return atan2(dy, dx)
    }

    public func normalized() -> CGVector {
        let m = magnitude
        assert(m > 0.0)
        return self / m
    }

    public func rotated(by theta: CGFloat) -> CGVector {
        let sinTheta = sin(theta)
        let cosTheta = cos(theta)
        return CGVector(dx: dx * cosTheta - dy * sinTheta, dy: dx * sinTheta + dy * cosTheta)
    }

    public static var unit = CGVector(dx: 1, dy: 0)
}

public func - (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
}

public func + (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
}

public func / (lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
}

public func / (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx / rhs.dx, dy: lhs.dy / rhs.dy)
}

public func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
}

public func * (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx * rhs.dx, dy: lhs.dy * rhs.dy)
}

public func dot(v1: CGVector, _ v2: CGVector) -> CGFloat {
    return v1.dx * v2.dx + v1.dy * v2.dy
}

public func cross(v1: CGVector, _ v2: CGVector) -> CGFloat {
    return v1.dx * v2.dy - v1.dy * v2.dx
}

extension CGVector: Interpolable {
    public func interpolated(to other: CGVector, at frac: Frac) -> CGVector {
        return CGVector(dx: dx.interpolated(to: other.dx, at: frac),
                        dy: dy.interpolated(to: other.dy, at: frac))
    }
}
