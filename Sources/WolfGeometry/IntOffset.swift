//
//  IntOffset.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 9/16/18.
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

import Foundation

public struct IntOffset {
    public var dx: Int
    public var dy: Int

    public init(dx: Int, dy: Int) {
        self.dx = dx
        self.dy = dy
    }

    public static let zero = IntOffset(dx: 0, dy: 0)

    public static let up = IntOffset(dx: 0, dy: -1)
    public static let left = IntOffset(dx: -1, dy: 0)
    public static let down = IntOffset(dx: 0, dy: 1)
    public static let right = IntOffset(dx: 1, dy: 0)
}

extension IntOffset: Equatable {
    public static func == (lhs: IntOffset, rhs: IntOffset) -> Bool {
        return lhs.dx == rhs.dx && lhs.dy == rhs.dy
    }
}

public prefix func - (rhs: IntOffset) -> IntOffset {
    return IntOffset(dx: -rhs.dx, dy: -rhs.dy)
}

public func + (lhs: IntOffset, rhs: IntOffset) -> IntOffset {
    return IntOffset(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
}

public func += (lhs: inout IntOffset, rhs: IntOffset) {
    lhs = lhs + rhs
}

extension IntOffset: CustomStringConvertible {
    public var description: String {
        get {
            return "Offset(dx:\(dx) dy:\(dy))"
        }
    }
}

public enum Heading {
    case up
    case left
    case down
    case right

    public var offset: IntOffset {
        switch self {
        case .up: return .up
        case .left: return .left
        case .down: return .down
        case .right: return .right
        }
    }

    public var nextClockwise: Heading {
        switch self {
        case .up: return .right
        case .left: return .up
        case .down: return .left
        case .right: return .down
        }
    }

    public var nextCounterClockwise: Heading {
        switch self {
        case .up: return .left
        case .left: return .down
        case .down: return .right
        case .right: return .up
        }
    }
}
