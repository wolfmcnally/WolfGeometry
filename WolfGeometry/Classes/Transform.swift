//
//  Transform.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 11/19/18.
//

import Foundation

private let ε = 2.22045e-16

public struct Transform : Hashable, CustomStringConvertible {
    public var m11, m12, m21, m22, tX, tY: Double

    /**
     Creates an affine transformation.
     */
    public init(m11: Double, m12: Double, m21: Double, m22: Double, tX: Double, tY: Double) {
        self.m11 = m11
        self.m12 = m12
        self.m21 = m21
        self.m22 = m22
        self.tX = tX
        self.tY = tY
    }

    /**
     Creates an affine transformation matrix with identity values.
     - seealso: identity
     */
    public init() {
        self.init(m11: 1.0, m12: 0.0,
                  m21: 0.0, m22: 1.0,
                  tX: 0.0, tY: 0.0)
    }

    /**
     Creates an affine transformation matrix from translation values.
     The matrix takes the following form:

     [ 1  0  0 ]
     [ 0  1  0 ]
     [ x  y  1 ]
     */
    public init(translationX x: Double, y: Double) {
        self.init(m11: 1.0, m12: 0.0,
                  m21: 0.0, m22: 1.0,
                  tX: x, tY: y)
    }

    public init(translation t: Vector) {
        self.init(translationX: t.dx, y: t.dy)
    }

    /**
     Creates an affine transformation matrix from scaling values.
     The matrix takes the following form:

     [ x  0  0 ]
     [ 0  y  0 ]
     [ 0  0  1 ]
     */
    public init(scaleX x: Double, y: Double) {
        self.init(m11: x,            m12: 0.0,
                  m21: 0.0, m22: y,
                  tX: 0.0,  tY: 0.0)
    }

    public init(scaling s: Vector) {
        self.init(scaleX: s.dx, y: s.dy)
    }

    /**
     Creates an affine transformation matrix from scaling a single value.
     The matrix takes the following form:

     [ f  0  0 ]
     [ 0  f  0 ]
     [ 0  0  1 ]
     */
    public init(scale factor: Double) {
        self.init(scaleX: factor, y: factor)
    }

    public func scaledBy(x: Double, y: Double) -> Transform {
        var t = self
        t.scale(x: x, y: y)
        return t
    }

    public func scaled(by v: Vector) -> Transform{
        return scaledBy(x: v.dx, y: v.dy)
    }

    /**
     Creates an affine transformation matrix from rotation value (angle in radians).
     The matrix takes the following form:

     [  cos α   sin α  0 ]
     [ -sin α   cos α  0 ]
     [    0       0    1 ]
     */
    public init(rotation angle: Double) {
        let α = angle

        let sine = sin(α)
        let cosine = cos(α)

        self.init(m11: cosine, m12: sine, m21: -sine, m22: cosine, tX: 0, tY: 0)
    }

    /**
     An identity affine transformation matrix

     [ 1  0  0 ]
     [ 0  1  0 ]
     [ 0  0  1 ]
     */
    public static let identity = Transform(m11: 1, m12: 0, m21: 0, m22: 1, tX: 0, tY: 0)

    // Translating

    public mutating func translate(by v: Vector) {
        translate(x: v.dx, y: v.dy)
    }

    public mutating func translate(x: Double, y: Double) {
        tX += m11 * x + m21 * y
        tY += m12 * x + m22 * y
    }

    public func translatedBy(x: Double, y: Double) -> Transform {
        var t = self
        t.translate(x: x, y: y)
        return t
    }

    public func translated(by v: Vector) -> Transform{
        return translatedBy(x: v.dx, y: v.dy)
    }

    /**
     Mutates an affine transformation matrix from a rotation value (angle α in radians).
     The matrix takes the following form:

     [  cos α   sin α  0 ]
     [ -sin α   cos α  0 ]
     [    0       0    1 ]
     */
    public mutating func rotate(angle: Double) {
        let t2 = self
        let t1 = Transform(rotation: angle)

        var t = Transform.identity

        t.m11 = t1.m11 * t2.m11 + t1.m12 * t2.m21
        t.m12 = t1.m11 * t2.m12 + t1.m12 * t2.m22
        t.m21 = t1.m21 * t2.m11 + t1.m22 * t2.m21
        t.m22 = t1.m21 * t2.m12 + t1.m22 * t2.m22
        t.tX = t1.tX * t2.m11 + t1.tY * t2.m21 + t2.tX
        t.tY = t1.tX * t2.m12 + t1.tY * t2.m22 + t2.tY

        self = t
    }

    public func rotated(by angle: Double) -> Transform {
        var t = self
        t.rotate(angle: angle)
        return t
    }

    /**
     Creates an affine transformation matrix by combining the receiver with `transformStruct`.
     That is, it computes `T * M` and returns the result, where `T` is the receiver's and `M` is
     the `transformStruct`'s affine transformation matrix.
     The resulting matrix takes the following form:

     [ m11_T  m12_T  0 ] [ m11_M  m12_M  0 ]
     T * M = [ m21_T  m22_T  0 ] [ m21_M  m22_M  0 ]
     [  tX_T   tY_T  1 ] [  tX_M   tY_M  1 ]

     [    (m11_T*m11_M + m12_T*m21_M)       (m11_T*m12_M + m12_T*m22_M)    0 ]
     = [    (m21_T*m11_M + m22_T*m21_M)       (m21_T*m12_M + m22_T*m22_M)    0 ]
     [ (tX_T*m11_M + tY_T*m21_M + tX_M)  (tX_T*m12_M + tY_T*m22_M + tY_M)  1 ]
     */
    private func concatenated(_ other: Transform) -> Transform {
        let (t, m) = (self, other)

        // this could be optimized with a vector version
        return Transform(
            m11: (t.m11 * m.m11) + (t.m12 * m.m21), m12: (t.m11 * m.m12) + (t.m12 * m.m22),
            m21: (t.m21 * m.m11) + (t.m22 * m.m21), m22: (t.m21 * m.m12) + (t.m22 * m.m22),
            tX: (t.tX * m.m11) + (t.tY * m.m21) + m.tX,
            tY: (t.tX * m.m12) + (t.tY * m.m22) + m.tY
        )
    }

    // Scaling
    public mutating func scale(_ scale: Double) {
        self.scale(x: scale, y: scale)
    }

    public mutating func scale(by v: Vector) {
        scale(x: v.dx, y: v.dy)
    }

    public mutating func scale(x: Double, y: Double) {
        m11 *= x
        m12 *= x
        m21 *= y
        m22 *= y
    }

    /**
     Inverts the transformation matrix if possible. Matrices with a determinant that is less than
     the smallest valid representation of a double value greater than zero are considered to be
     invalid for representing as an inverse. If the input Transform can potentially fall into
     this case then the inverted() method is suggested to be used instead since that will return
     an optional value that will be nil in the case that the matrix cannot be inverted.

     D = (m11 * m22) - (m12 * m21)

     D < ε the inverse is undefined and will be nil
     */
    public mutating func invert() {
        guard let inverse = inverted() else {
            fatalError("Transform has no inverse")
        }
        self = inverse
    }

    public func inverted() -> Transform? {
        let determinant = (m11 * m22) - (m12 * m21)
        if abs(determinant) <= ε {
            return nil
        }
        var inverse = Transform()
        inverse.m11 = m22 / determinant
        inverse.m12 = -m12 / determinant
        inverse.m21 = -m21 / determinant
        inverse.m22 = m11 / determinant
        inverse.tX = (m21 * tY - m22 * tX) / determinant
        inverse.tY = (m12 * tX - m11 * tY) / determinant
        return inverse
    }

    // Transforming with transform
    public mutating func append(_ transform: Transform) {
        self = concatenated(transform)
    }

    public mutating func prepend(_ transform: Transform) {
        self = transform.concatenated(self)
    }

    public var hashValue : Int {
        return Int(m11 + m12 + m21 + m22 + tX + tY)
    }

    public var description: String {
        return "{m11:\(m11), m12:\(m12), m21:\(m21), m22:\(m22), tX:\(tX), tY:\(tY)}"
    }

    public var debugDescription: String {
        return description
    }

    public static func ==(lhs: Transform, rhs: Transform) -> Bool {
        return lhs.m11 == rhs.m11 && lhs.m12 == rhs.m12 &&
            lhs.m21 == rhs.m21 && lhs.m22 == rhs.m22 &&
            lhs.tX == rhs.tX && lhs.tY == rhs.tY
    }

}

extension Point {
    public func applying(_ t: Transform) -> Point {
        let x2 = (t.m11 * x) + (t.m21 * y) + t.tX
        let y2 = (t.m12 * x) + (t.m22 * y) + t.tY
        return Point(x: x2, y: y2)
    }
}

extension Size {
    public func applying(_ t: Transform) -> Size {
        let x2 = (t.m11 * width) + (t.m21 * height) + t.tX
        let y2 = (t.m12 * width) + (t.m22 * height) + t.tY
        return Size(width: x2, height: y2)
    }
}

extension Vector {
    public func applying(_ t: Transform) -> Vector {
        let x2 = (t.m11 * dx) + (t.m21 * dy) + t.tX
        let y2 = (t.m12 * dx) + (t.m22 * dy) + t.tY
        return Vector(dx: x2, dy: y2)
    }
}

extension Transform : Codable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        m11 = try container.decode(Double.self)
        m12 = try container.decode(Double.self)
        m21 = try container.decode(Double.self)
        m22 = try container.decode(Double.self)
        tX  = try container.decode(Double.self)
        tY  = try container.decode(Double.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.m11)
        try container.encode(self.m12)
        try container.encode(self.m21)
        try container.encode(self.m22)
        try container.encode(self.tX)
        try container.encode(self.tY)
    }
}

extension Transform {
    public mutating func rotated(by angle: Double, around point: Point) -> Transform {
        return translatedBy(x: point.x, y: point.y).rotated(by: angle).translatedBy(x: -point.x, y: -point.y)
    }
}
