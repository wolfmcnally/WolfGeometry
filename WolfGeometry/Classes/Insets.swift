//
//  Insets.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 6/16/17.
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

public struct Insets<T: BinaryFloatingPoint> {
    public var top: T?
    public var left: T?
    public var bottom: T?
    public var right: T?

    public init(top: T? = nil, left: T? = nil, bottom: T? = nil, right: T? = nil) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }

    public init(all n: T) {
        self.init(top: n, left: n, bottom: n, right: n)
    }

    public init(size: T) {
        self.init(top: size, left: size, bottom: size, right: size)
    }

    public init(horizontal h: T, vertical v: T) {
        self.init(top: v, left: h, bottom: v, right: h)
    }

    public static var zero: Insets { return Insets(top: 0, left: 0, bottom: 0, right: 0) }

    public var horizontal: T {
        return (left ?? 0) + (right ?? 0)
    }

    public var vertical: T {
        return (top ?? 0) + (bottom ?? 0)
    }
}

#if canImport(CoreGraphics)
    import CoreGraphics

    public typealias CGInsets = Insets<CGFloat>
#endif

#if canImport(UIKit)
    import UIKit

    extension Insets where T == CGFloat {
        public init(edgeInsets e: UIEdgeInsets) {
            self.init(top: e.top, left: e.left, bottom: e.bottom, right: e.right)
        }
    }

    extension UIEdgeInsets {
        public init(all n: CGFloat) {
            self.init(top: n, left: n, bottom: n, right: n)
        }

        public init(horizontal h: CGFloat, vertical v: CGFloat) {
            self.init(top: v, left: h, bottom: v, right: h)
        }

        public var horizontal: CGFloat {
            return left + right
        }

        public var vertical: CGFloat {
            return top + bottom
        }
    }

    public func + (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: lhs.top + rhs.top, left: lhs.left + rhs.left, bottom: lhs.bottom + rhs.bottom, right: lhs.right + rhs.right)
    }

    #if swift(>=4.2)
    // Workaround for https://bugs.swift.org/browse/SR-7879
    extension UIEdgeInsets {
        static let zero = UIEdgeInsets()
    }
    #endif
#endif
