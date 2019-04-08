//
//  Size.swift
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

import WolfCore

#if canImport(CoreGraphics)
import CoreGraphics
#endif

public struct Size {
    public var width: Double = 0
    public var height: Double = 0

    public static let None = -1.0

    public init() {
        width = 0.0
        height = 0.0
    }

    public init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

#if !os(Linux)
    extension Size {
        public init(s: CGSize) {
            width = Double(s.width)
            height = Double(s.height)
        }

        public var cgSize: CGSize {
            return CGSize(width: CGFloat(width), height: CGFloat(height))
        }
    }
#endif

extension Size {
    public init(both n: Double) {
        self.init(width: n, height: n)
    }

    public init(_ vector: Vector) {
        width = vector.dx
        height = vector.dy
    }

    public var aspect: Double {
        return width / height
    }

    public var bounds: Rect {
        return Rect(origin: .zero, size: self)
    }

    public func scaleForAspectFit(within size: Size) -> Double {
        if size.width != Size.None && size.height != Size.None {
            return Swift.min(size.width / width, size.height / height)
        } else if size.width != Size.None {
            return size.width / width
        } else {
            return size.height / height
        }
    }

    public func scaleForAspectFill(within size: Size) -> Double {
        if size.width != Size.None && size.height != Size.None {
            return Swift.max(size.width / width, size.height / height)
        } else if size.width != Size.None {
            return size.width / width
        } else {
            return size.height / height
        }
    }

    public func aspectFit(within size: Size) -> Size {
        let scale = scaleForAspectFit(within: size)
        return Size(Vector(self) * scale)
    }

    public func aspectFill(within size: Size) -> Size {
        let scale = scaleForAspectFill(within: size)
        return Size(Vector(self) * scale)
    }

    public var max: Double {
        return Swift.max(width, height)
    }

    public var min: Double {
        return Swift.min(width, height)
    }
}

extension Size: CustomStringConvertible {
    public var description: String {
        return("Size(\(width), \(height))")
    }
}

extension Size {
    public static let zero = Size()
    public static let infinite = Size(width: Double.infinity, height: Double.infinity)

    public init(width: Int, height: Int) {
        self.width = Double(width)
        self.height = Double(height)
    }

    public init(width: Float, height: Float) {
        self.width = Double(width)
        self.height = Double(height)
    }
}

extension Size: Equatable {
}

public func == (lhs: Size, rhs: Size) -> Bool {
    return lhs.width == rhs.width && lhs.height == rhs.height
}

extension Size {
    public var isEmpty: Bool { return width == 0.0 || height == 0.0 }
}

public func * (lhs: Size, rhs: Double) -> Size {
    return Size(width: lhs.width * rhs, height: lhs.height * rhs)
}

public func / (lhs: Size, rhs: Double) -> Size {
    return Size(width: lhs.width / rhs, height: lhs.height / rhs)
}

extension Size: Interpolable {
    public func interpolated(to other: Size, at frac: Frac) -> Size {
        return Size(width: width.interpolated(to: other.width, at: frac),
                    height: height.interpolated(to: other.height, at: frac))
    }
}

#if canImport(CoreGraphics)
extension Size {
    public init(_ s: CGSize) {
        self.init(width: Double(s.width), height: Double(s.height))
    }
}

extension CGSize {
    public init(_ s: Size) {
        self.init(width: CGFloat(s.width), height: CGFloat(s.height))
    }
}
#endif

extension Size : Codable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        width = try container.decode(Double.self)
        height = try container.decode(Double.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(width)
        try container.encode(height)
    }
}
