//
//  Rect.swift
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

import WolfNumerics

#if canImport(Glibc)
    import Glibc
#elseif canImport(CoreGraphics)
    import CoreGraphics
#endif

import Foundation

public struct Rect {
    public var origin: Point
    public var size: Size

    public init() {
        origin = Point.zero
        size = Size.zero
    }

    public init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }

    public init(minX: Double, minY: Double, maxX: Double, maxY: Double) {
        self.init(origin: Point(x: minX, y: minY), size: Size(width: maxX - minX, height: maxY - minY))
    }
}

extension Rect: CustomStringConvertible {
    public var description: String {
        return("Rect(\(minX), \(minY), \(width), \(height))")
    }
}

extension Rect {
    public static let zero = Rect()
    public static let null = Rect(origin: .infinite, size: .zero)
    public static let infinite = Rect(origin: Point(x: -Double.infinity, y: -Double.infinity), size: .infinite)
}

extension Rect {
    public init(x: Double, y: Double, width: Double, height: Double) {
        self.init(origin: Point(x: x, y: y), size: Size(width: width, height: height))
    }

    public init(x: Float, y: Float, width: Float, height: Float) {
        self.init(origin: Point(x: x, y: y), size: Size(width: width, height: height))
    }

    public init(x: Int, y: Int, width: Int, height: Int) {
        self.init(origin: Point(x: x, y: y), size: Size(width: width, height: height))
    }
}

extension Rect {
    public var width: Double {
        get { return size.width }
        mutating set { size.width = newValue }
    }

    public var height: Double {
        get { return size.height }
        mutating set { size.height = newValue }
    }
}

extension Rect {
    public var minX: Double {
        get { return origin.x }
        mutating set { origin.x = newValue }
    }

    public var midX: Double {
        get { return minX + width / 2.0 }
        mutating set { origin.x = newValue - width / 2.0 }
    }

    public var maxX: Double {
        get { return minX + width }
        mutating set { origin.x = newValue - width }
    }

    public var minY: Double {
        get { return origin.y }
        mutating set { origin.y = newValue }
    }

    public var midY: Double {
        get { return minY + height / 2.0 }
        mutating set { origin.y = newValue - height / 2.0 }
    }

    public var maxY: Double {
        get { return minY + height }
        mutating set { origin.y = newValue - height }
    }
}

extension Rect {
    // Corners
    public var minXminY: Point {
        get { return origin }
        mutating set { origin = newValue }
    }

    public var maxXminY: Point {
        get { return Point(x: maxX, y: minY) }
        mutating set { maxX = newValue.x; minY = newValue.y }
    }

    public var minXmaxY: Point {
        get { return Point(x: minX, y: maxY) }
        mutating set { minX = newValue.x; maxY = newValue.y }
    }

    public var maxXmaxY: Point {
        get { return Point(x: maxX, y: maxY) }
        mutating set { maxX = newValue.x; maxY = newValue.y }
    }

    // Sides
    public var midXminY: Point {
        get { return Point(x: midX, y: minY) }
        mutating set { midX = newValue.x; minY = newValue.y }
    }

    public var midXmaxY: Point {
        get { return Point(x: midX, y: maxY) }
        mutating set { midX = newValue.x; maxY = newValue.y }
    }

    public var maxXmidY: Point {
        get { return Point(x: maxX, y: midY) }
        mutating set { maxX = newValue.x; midY = newValue.y }
    }

    public var minXmidY: Point {
        get { return Point(x: minX, y: midY) }
        mutating set { minX = newValue.x; midY = newValue.y }
    }

    // Center
    public var midXmidY: Point {
        get { return Point(x: midX, y: midY) }
        mutating set { midX = newValue.x; midY = newValue.y }
    }
}

extension Rect {
    public var isNull: Bool { return self.origin == .infinite }
    public var isEmpty: Bool { return self.isNull || size.isEmpty }
    public var isInfinite: Bool { return self == .infinite }
}

extension Rect {
    public var standardized: Rect {
        guard !isNull else { return self }
        var r = self
        if width < 0 {
            r.width = -r.width
            r.minX -= r.width
        }
        if height < 0 {
            r.height = -r.height
            r.minY -= r.height
        }
        return r
    }

    public mutating func standardizeInPlace() {
        self = self.standardized
    }

    public var integral: Rect {
        guard !isNull else { return self }
        return Rect(x: floor(minX), y: floor(minY), width: ceil(width), height: ceil(width))
    }

    public mutating func makeIntegralInPlace() {
        self = self.integral
    }
}

extension Rect {
    public func offsetBy(dx: Double, dy: Double) -> Rect {
        guard !isNull else { return self }
        return Rect(x: minX + dx, y: minY + dy, width: width, height: height)
    }

    public mutating func offsetInPlace(dx: Double, dy: Double) {
        self = offsetBy(dx: dx, dy: dy)
    }

    public func insetBy(dx: Double, dy: Double) -> Rect {
        guard !isNull else { return self }
        var r = self.standardized
        r.minX += dx
        r.width -= dx * 2
        r.minY += dy
        r.height -= dy * 2
        if r.width < 0.0 || r.height < 0.0 {
            r = .null
        }
        return r
    }

    public mutating func insetInPlace(dx: Double, dy: Double) {
        self = insetBy(dx: dx, dy: dy)
    }
}

extension Rect {
    public func union(_ rect: Rect) -> Rect {
        guard !self.isNull else { return rect }
        guard !rect.isNull else { return self }
        let r1 = self.standardized
        let r2 = rect.standardized
        let x1 = min(r1.minX, r2.minX)
        let x2 = max(r1.maxX, r2.maxX)
        let y1 = min(r1.minY, r2.minY)
        let y2 = max(r1.maxY, r2.maxY)
        return Rect(x: x1, y: y1, width: x2 - x1, height: y2 - y1)
    }

    public mutating func formUnion(rect: Rect) {
        self = self.union(rect)
    }

    public func intersect(_ rect: Rect) -> Rect {
        guard !self.isNull else { return .null }
        guard !rect.isNull else { return .null }
        let r1 = self.standardized
        let r2 = rect.standardized
        guard r1.maxX > r2.minX else { return .null }
        guard r1.maxY > r2.minY else { return .null }
        guard r1.minX < r2.maxX else { return .null }
        guard r1.minY < r2.minY else { return .null }
        let x1 = max(r1.minX, r2.minX)
        let x2 = min(r1.maxX, r2.maxX)
        let y1 = max(r1.minY, r2.minY)
        let y2 = min(r1.maxY, r2.maxY)
        return Rect(x: x1, y: y1, width: x2 - x1, height: y2 - y1)
    }

    public mutating func formIntersection(_ rect: Rect) {
        self = self.intersect(rect)
    }

    public func intersects(_ rect: Rect) -> Bool {
        guard !self.isNull else { return false }
        guard !rect.isNull else { return false }
        let r1 = self.standardized
        let r2 = rect.standardized
        guard r1.maxX > r2.minX else { return false }
        guard r1.maxY > r2.minY else { return false }
        guard r1.minX < r2.maxX else { return false }
        guard r1.minY < r2.minY else { return false }
        return true
    }
}

extension Rect {
    public func contains(_ point: Point) -> Bool {
        guard !self.isNull else { return false }
        guard !self.isEmpty else { return false }
        let r = self.standardized
        guard point.x >= r.minX else { return false }
        guard point.y >= r.minY else { return false }
        guard point.x < r.maxX else { return false }
        guard point.y < r.maxY else { return false }
        return true
    }

    public func contains(_ rect: Rect) -> Bool {
        guard !self.isNull else { return false }
        guard !rect.isNull else { return false }
        return self.union(rect) == self
    }
}

public enum RectEdge {
    case minX
    case minY
    case maxX
    case maxY
}

extension Rect {
    public func divide(atDistance distance: Double, fromEdge edge: RectEdge) -> (slice: Rect, remainder: Rect) {
        guard !self.isNull else { return (.null, .null) }
        guard distance > 0.0 else { return (.null, self) }
        let slice: Rect
        let remainder: Rect
        switch edge {
        case .minX:
            guard distance < width else { return (self, .null) }
            let x1 = minX
            let x2 = x1 + distance
            let x3 = maxX
            let y1 = minY
            let y2 = maxY
            slice = Rect(minX: x1, minY: y1, maxX: x2, maxY: y2)
            remainder = Rect(minX: x2, minY: y1, maxX: x3, maxY: y2)
        case .minY:
            guard distance < height else { return (self, .null) }
            let y1 = minY
            let y2 = y1 + distance
            let y3 = maxY
            let x1 = minX
            let x2 = maxX
            slice = Rect(minX: x1, minY: y1, maxX: x2, maxY: y2)
            remainder = Rect(minX: x1, minY: y2, maxX: x2, maxY: y3)
        case .maxX:
            guard distance < width else { return (self, .null) }
            let x3 = maxX
            let x2 = x3 - distance
            let x1 = minX
            let y1 = minY
            let y2 = maxY
            slice = Rect(minX: x2, minY: y1, maxX: x3, maxY: y2)
            remainder = Rect(minX: x1, minY: y1, maxX: x2, maxY: y2)
        case .maxY:
            guard distance < height else { return (self, .null) }
            let y3 = maxY
            let y2 = y3 - distance
            let y1 = minY
            let x1 = minX
            let x2 = maxX
            slice = Rect(minX: x1, minY: y2, maxX: x2, maxY: y3)
            remainder = Rect(minX: x1, minY: y1, maxX: x2, maxY: y2)
        }
        return (slice, remainder)
    }
}

extension Rect: Equatable {
}

public func == (lhs: Rect, rhs: Rect) -> Bool {
    return lhs.origin == rhs.origin && lhs.size == rhs.size
}

extension Rect: Interpolable {
    public func interpolated(to other: Rect, at frac: Frac) -> Rect {
        return Rect(origin: origin.interpolated(to: other.origin, at: frac),
                    size: size.interpolated(to: other.size, at: frac))
    }
}

#if canImport(CoreGraphics)
extension Rect {
    public init(_ r: CGRect) {
        self.init(origin: Point(r.origin), size: Size(r.size))
    }
}

extension CGRect {
    public init(_ r: Rect) {
        self.init(origin: CGPoint(r.origin), size: CGSize(r.size))
    }
}
#endif

extension Rect : Codable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let x = try container.decode(Double.self)
        let y = try container.decode(Double.self)
        let width = try container.decode(Double.self)
        let height = try container.decode(Double.self)
        self.init(x: x, y: y, width: width, height: height)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(origin.x)
        try container.encode(origin.y)
        try container.encode(size.width)
        try container.encode(size.height)
    }
}
