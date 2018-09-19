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

import WolfNumerics

public let piOverTwo: Double = .pi / 2.0
public let twoPi: Double = .pi * 2.0

public let a: Double = sin(.pi)

public func degrees<T: BinaryFloatingPoint>(for radians: T) -> T {
    return radians / .pi * 180.0
}

public func radians<T: BinaryFloatingPoint>(for degrees: T) -> T {
    return degrees / 180.0 * .pi
}

// These versions use parabola segments (hermite curves)
public func easeOutFaster<T: BinaryFloatingPoint>(_ t: T) -> T { return 2 * t - t * t }
public func easeInFaster<T: BinaryFloatingPoint>(_ t: T) -> T { return t * t }
public func easeInAndOutFaster<T: BinaryFloatingPoint>(_ t: T) -> T { return t * t * (3.0 - 2.0 * t) }

// These versions use sine curve segments, and are more computationally intensive
public func easeOut(_ t: Float) -> Float { return sin(t * .pi / 2) }
public func easeIn(_ t: Float) -> Float { return 1.0 - cos(t * .pi / 2) }
public func easeInAndOut(_ t: Float) -> Float { return 0.5 * (1 + sin(.pi * (t - 0.5))) }

public func easeOut(_ t: Double) -> Double { return sin(t * .pi / 2) }
public func easeIn(_ t: Double) -> Double { return 1.0 - cos(t * .pi / 2) }
public func easeInAndOut(_ t: Double) -> Double { return 0.5 * (1 + sin(.pi * (t - 0.5))) }

#if !os(Linux)
    public func easeOut(_ t: CGFloat) -> CGFloat { return sin(t * .pi / 2) }
    public func easeIn(_ t: CGFloat) -> CGFloat { return 1.0 - cos(t * .pi / 2) }
    public func easeInAndOut(_ t: CGFloat) -> CGFloat { return 0.5 * (1 + sin(.pi * (t - 0.5))) }
#endif

public func triangleUpThenDown<T: BinaryFloatingPoint>(_ t: T) -> T {
    return t < 0.5 ? t.lerped(from: 0.0..0.5, to: 0.0..1.0) : t.lerped(from: 0.5..1.0, to: 1.0..0.0)
}

public func triangleDownThenUp<T: BinaryFloatingPoint>(_ t: T) -> T {
    return t < 0.5 ? t.lerped(from: 0.0..0.5, to: 1.0..0.0) : t.lerped(from: 0.5..1.0, to: 0.0..1.0)
}

public func sawtoothUp<T: BinaryFloatingPoint>(_ t: T) -> T { return t }
public func sawtoothDown<T: BinaryFloatingPoint>(_ t: T) -> T { return 1.0 - t }

public func sineUpThenDown(_ t: Float) -> Float { return sin(t * .pi * 2) * 0.5 + 0.5 }
public func sineDownThenUp(_ t: Float) -> Float { return 1.0 - sin(t * .pi * 2) * 0.5 + 0.5 }
public func cosineUpThenDown(_ t: Float) -> Float { return 1.0 - cos(t * .pi * 2) * 0.5 + 0.5 }
public func cosineDownThenUp(_ t: Float) -> Float { return cos(t * .pi * 2) * 0.5 + 0.5 }
public func miterLength(lineWidth: Float, phi: Float) -> Float { return lineWidth * (1.0 / sin(phi / 2.0)) }

public func sineUpThenDown(_ t: Double) -> Double { return sin(t * .pi * 2) * 0.5 + 0.5 }
public func sineDownThenUp(_ t: Double) -> Double { return 1.0 - sin(t * .pi * 2) * 0.5 + 0.5 }
public func cosineUpThenDown(_ t: Double) -> Double { return 1.0 - cos(t * .pi * 2) * 0.5 + 0.5 }
public func cosineDownThenUp(_ t: Double) -> Double { return cos(t * .pi * 2) * 0.5 + 0.5 }
public func miterLength(lineWidth: Double, phi: Double) -> Double { return lineWidth * (1.0 / sin(phi / 2.0)) }

#if !os(Linux)
    public func sineUpThenDown(_ t: CGFloat) -> CGFloat { return sin(t * .pi * 2) * 0.5 + 0.5 }
    public func sineDownThenUp(_ t: CGFloat) -> CGFloat { return 1.0 - sin(t * .pi * 2) * 0.5 + 0.5 }
    public func cosineUpThenDown(_ t: CGFloat) -> CGFloat { return 1.0 - cos(t * .pi * 2) * 0.5 + 0.5 }
    public func cosineDownThenUp(_ t: CGFloat) -> CGFloat { return cos(t * .pi * 2) * 0.5 + 0.5 }
    public func miterLength(lineWidth: CGFloat, phi: CGFloat) -> CGFloat { return lineWidth * (1.0 / sin(phi / 2.0)) }
#endif

public func angleOfLineSegment(_ p1: Point, _ p2: Point) -> Double {
    return Vector(p1, p2).angle
}

public func angleBetweenVectors(_ v1: Vector, _ v2: Vector) -> Double {
    return atan2(cross(v1, v2), dot(v1, v2))
}

public func turningAngleAtVertex(_ p1: Point, _ p2: Point, _ p3: Point) -> Double {
    let v1 = Vector(p1, p2)
    let v2 = Vector(p2, p3)
    return angleBetweenVectors(v1, v2)
}

public func meetingAngleAtVertex(_ p1: Point, _ p2: Point, _ p3: Point) -> Double {
    let v1 = Vector(p1, p2)
    let v2 = Vector(p3, p2)
    return angleBetweenVectors(v1, v2)
}

public func partingAngleAtVertex(_ p1: Point, _ p2: Point, _ p3: Point) -> Double {
    let v1 = Vector(p2, p1)
    let v2 = Vector(p2, p3)
    return angleBetweenVectors(v1, v2)
}

//
// http://math.stackexchange.com/questions/797828/calculate-center-of-circle-tangent-to-two-lines-in-space
//
public func infoForRoundedCornerArcAtVertex(withRadius radius: Double, _ p1: Point, _ p2: Point, _ p3: Point) -> (center: Point, startPoint: Point, startAngle: Double, endPoint: Point, endAngle: Double, clockwise: Bool) {
    let alpha = partingAngleAtVertex(p1, p2, p3)
    let distanceFromVertexToCenter = radius / (sin(alpha / 2))

    let p1p2angle = angleOfLineSegment(p1, p2)
    let bisectionAngle = alpha / 2.0
    let centerAngle = p1p2angle + bisectionAngle
    let center = Point(center: p2, angle: centerAngle, radius: distanceFromVertexToCenter)
    let startAngle = p1p2angle - .pi / 2
    let endAngle = angleOfLineSegment(p2, p3) - .pi / 2
    let clockwise = true // TODO
    let startPoint = Point(center: center, angle: startAngle, radius: radius)
    let endPoint = Point(center: center, angle: endAngle, radius: radius)

    return (center, startPoint, startAngle, endPoint, endAngle, clockwise)
}
