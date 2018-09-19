//
//  SizeExtensions.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 12/21/15.
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
import CoreGraphics
import WolfStrings

#if canImport(UIKit)
    import UIKit
#endif

#if os(iOS) || os(tvOS)
    public let noSize = UIView.noIntrinsicMetric
#else
    public let noSize: CGFloat = -1.0
#endif

extension CGSize {
    public static var none = CGSize(width: noSize, height: noSize)

    public init(vector: CGVector) {
        self.init(width: vector.dx, height: vector.dy)
    }

    public var aspect: CGFloat {
        return width / height
    }

    public func scaleForAspectFit(within size: CGSize) -> CGFloat {
        if size.width != noSize && size.height != noSize {
            return Swift.min(size.width / width, size.height / height)
        } else if size.width != noSize {
            return size.width / width
        } else {
            return size.height / height
        }
    }

    public func scaleForAspectFill(within size: CGSize) -> CGFloat {
        if size.width != noSize && size.height != noSize {
            return Swift.max(size.width / width, size.height / height)
        } else if size.width != noSize {
            return size.width / width
        } else {
            return 1.0
        }
    }

    public func aspectFit(within size: CGSize) -> CGSize {
        let scale = scaleForAspectFit(within: size)
        return CGSize(vector: CGVector(size: self) * scale)
    }

    public func aspectFill(within size: CGSize) -> CGSize {
        let scale = scaleForAspectFill(within: size)
        return CGSize(vector: CGVector(size: self) * scale)
    }

    public var max: CGFloat {
        return Swift.max(width, height)
    }

    public var min: CGFloat {
        return Swift.min(width, height)
    }

    public func swapped() -> CGSize {
        return CGSize(width: height, height: width)
    }

    public var bounds: CGRect {
        return CGRect(origin: .zero, size: self)
    }

    public var asPoint: CGPoint {
        return CGPoint(x: width, y: height)
    }
}

extension CGSize {
    public var isLandscape: Bool {
        return width > height
    }

    public var isPortrait: Bool {
        return height > width
    }

    public var isSquare: Bool {
        return width == height
    }

    public var debugSummary: String {
        let joiner = Joiner(left: "(", right: ")")
        joiner.append(width %% 3, height %% 3)
        return joiner.description
    }
}

public func + (left: CGSize, right: CGSize) -> CGVector {
    return CGVector(dx: left.width + right.width, dy: left.height + right.height)
}

public func - (left: CGSize, right: CGSize) -> CGVector {
    return CGVector(dx: left.width - right.width, dy: left.height - right.height)
}

public func + (left: CGSize, right: CGVector) -> CGSize {
    return CGSize(width: left.width + right.dx, height: left.height + right.dy)
}

public func - (left: CGSize, right: CGVector) -> CGSize {
    return CGSize(width: left.width - right.dx, height: left.height - right.dy)
}

public func + (left: CGVector, right: CGSize) -> CGSize {
    return CGSize(width: left.dx + right.width, height: left.dy + right.height)
}

public func - (left: CGVector, right: CGSize) -> CGSize {
    return CGSize(width: left.dx - right.width, height: left.dy - right.height)
}

public func * (left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}
