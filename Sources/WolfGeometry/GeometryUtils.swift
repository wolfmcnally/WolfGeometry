//
//  GeometryUtils.swift
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

#if canImport(Glibc)
    import Glibc
#elseif canImport(Darwin)
    import Darwin
#endif

#if canImport(CoreGraphics)
    import CoreGraphics
#endif

import WolfCore

public let piOverTwo: Double = .pi / 2.0
public let twoPi: Double = .pi * 2.0

public let a: Double = sin(.pi)

public func degrees<T: BinaryFloatingPoint>(for radians: T) -> T {
    return radians / .pi * 180.0
}

public func radians<T: BinaryFloatingPoint>(for degrees: T) -> T {
    return degrees / 180.0 * .pi
}
public func miterLength(lineWidth: Float, phi: Float) -> Float { return lineWidth * (1.0 / sin(phi / 2.0)) }
public func miterLength(lineWidth: Double, phi: Double) -> Double { return lineWidth * (1.0 / sin(phi / 2.0)) }

#if !os(Linux)
public func miterLength(lineWidth: CGFloat, phi: CGFloat) -> CGFloat { return lineWidth * (1.0 / sin(phi / 2.0)) }
#endif

public func angleOfLineSegment(_ p1: Point, _ p2: Point) -> Double {
    return Vector(p1, p2).angle
}

public func angleBetweenVectors(_ v1: Vector, _ v2: Vector) -> Double {
    return atan2(cross(v1, v2), dot(v1, v2))
}

public func angleAtVertex(o: Point, _ p1: Point, _ p2: Point) -> Double {
    return angleBetweenVectors(Vector(o, p1), Vector(o, p2))
}

//
// https://math.stackexchange.com/questions/405966/if-i-have-three-points-is-there-an-easy-way-to-tell-if-they-are-collinear
//
public func isCollinear(p1: Point, p2: Point, p3: Point, within tolerance: Double) -> Bool {
    return abs((p3.y - p2.y) * (p1.x - p3.x) - (p1.y - p3.y) * (p3.x - p2.x)) < tolerance
}

//
// http://math.stackexchange.com/questions/797828/calculate-center-of-circle-tangent-to-two-lines-in-space
//
public func infoForRoundedCornerArcAtVertex(withRadius radius: Double, o: Point, _ p1: Point, _ o2: Point) -> (center: Point, startPoint: Point, startAngle: Double, endPoint: Point, endAngle: Double, clockwise: Bool) {
    let alpha = angleAtVertex(o: o, p1, o2)
    let distanceFromVertexToCenter = radius / (sin(alpha / 2))

    let p1p2angle = angleOfLineSegment(p1, o)
    let bisectionAngle = alpha / 2.0
    let centerAngle = p1p2angle + bisectionAngle
    let center = Point(center: o, angle: centerAngle, radius: distanceFromVertexToCenter)
    let startAngle = p1p2angle - .pi / 2
    let endAngle = angleOfLineSegment(o, o2) - .pi / 2
    let clockwise = true // TODO
    let startPoint = Point(center: center, angle: startAngle, radius: radius)
    let endPoint = Point(center: center, angle: endAngle, radius: radius)

    return (center, startPoint, startAngle, endPoint, endAngle, clockwise)
}
