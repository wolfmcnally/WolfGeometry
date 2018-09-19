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
