//
//  AffineTransformExtensions.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 6/25/17.
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

extension CGAffineTransform {
    public init(scaling s: CGVector) {
        self.init(scaleX: s.dx, y: s.dy)
    }

    public init(translation t: CGVector) {
        self.init(translationX: t.dx, y: t.dy)
    }

    public func scaled(by v: CGVector) -> CGAffineTransform {
        return scaledBy(x: v.dx, y: v.dy)
    }

    public func translated(by v: CGVector) -> CGAffineTransform {
        return translatedBy(x: v.dx, y: v.dy)
    }

    public func rotated(by angle: CGFloat, around point: CGPoint) -> CGAffineTransform {
        return translatedBy(x: point.x, y: point.y).rotated(by: angle).translatedBy(x: -point.x, y: -point.y)
    }
}

extension CGAffineTransform {
    public init(scaling s: Vector) {
        self.init(scaleX: s.dx, y: s.dy)
    }

    public init(translation t: Vector) {
        self.init(translationX: t.dx, y: t.dy)
    }

    public func scaled(by v: Vector) -> CGAffineTransform {
        return scaledBy(x: v.dx, y: v.dy)
    }

    public func translated(by v: Vector) -> CGAffineTransform {
        return translatedBy(x: v.dx, y: v.dy)
    }

    public func rotated(by angle: Double, around point: Point) -> CGAffineTransform {
        return translatedBy(x: point.x, y: point.y).rotated(by: angle).translatedBy(x: -point.x, y: -point.y)
    }
}

extension CGAffineTransform {
    public init(a: Double, b: Double, c: Double, d: Double, tx: Double, ty: Double) {
        self.init(a: CGFloat(a), b: CGFloat(b), c: CGFloat(c), d: CGFloat(d), tx: CGFloat(tx), ty: CGFloat(ty))
    }

    public init(translationX tx: Double, y ty: Double) {
        self.init(translationX: CGFloat(tx), y: CGFloat(ty))
    }

    public init(scaleX sx: Double, y sy: Double) {
        self.init(scaleX: CGFloat(sx), y: CGFloat(sy))
    }

    public init(rotationAngle angle: Double) {
        self.init(rotationAngle: CGFloat(angle))
    }

    public func translatedBy(x tx: Double, y ty: Double) -> CGAffineTransform {
        return translatedBy(x: CGFloat(tx), y: CGFloat(ty))
    }

    public func scaledBy(x sx: Double, y sy: Double) -> CGAffineTransform {
        return scaledBy(x: CGFloat(sx), y: CGFloat(sy))
    }

    public func rotated(by angle: Double) -> CGAffineTransform {
        return rotated(by: CGFloat(angle))
    }
}
