//
//  PointExtensions.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 7/12/15.
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
import WolfNumerics
import WolfStrings

extension CGPoint {
    public init(vector: CGVector) {
        self.init(x: vector.dx, y: vector.dy)
    }

    public init(center: CGPoint, angle theta: CGFloat, radius: CGFloat) {
        self.init(x: center.x + cos(theta) * radius, y: center.y + sin(theta) * radius)
    }

    public var magnitude: CGFloat {
        return hypot(x, y)
    }

    public var angle: CGFloat {
        return atan2(y, x)
    }

    public func distance(to point: CGPoint) -> CGFloat {
        return (point - self).magnitude
    }

    public func rotated(by theta: CGFloat, aroundCenter center: CGPoint) -> CGPoint {
        let v = center - self
        let v2 = v.rotated(by: theta)
        let p = center + v2
        return p
    }

    public var asSize: CGSize {
        return CGSize(width: x, height: y)
    }
}

extension CGPoint {
    public func settingX(_ newX: CGFloat) -> CGPoint { return CGPoint(x: newX, y: y) }
    public func settingY(_ newY: CGFloat) -> CGPoint { return CGPoint(x: x, y: newY) }
}

extension CGPoint {
    public var debugSummary: String {
        let joiner = Joiner(left: "(", right: ")")
        joiner.append(x %% 3, y %% 3)
        return joiner.description
    }
}

extension CGPoint: Interpolable {
    public func interpolated(to other: CGPoint, at frac: Frac) -> CGPoint {
        return CGPoint(x: x.interpolated(to: other.x, at: frac),
                       y: y.interpolated(to: other.y, at: frac))
    }
}

public func + (lhs: CGPoint, rhs: CGPoint) -> CGVector {
    return CGVector(dx: lhs.x + rhs.x, dy: lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGVector {
    return CGVector(dx: lhs.x - rhs.x, dy: lhs.y - rhs.y)
}

public func + (lhs: CGPoint, rhs: CGVector) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
}

public func - (lhs: CGPoint, rhs: CGVector) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.dx, y: lhs.y - rhs.dy)
}

public func + (lhs: CGVector, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.dx + rhs.x, y: lhs.dy + rhs.y)
}

public func - (lhs: CGVector, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.dx - rhs.x, y: lhs.dy - rhs.y)
}
