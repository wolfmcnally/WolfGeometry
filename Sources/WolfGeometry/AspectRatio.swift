//
//  AspectRatio.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 4/12/17.
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

public struct AspectRatio: ExtensibleEnumeratedName {
    private typealias `Self` = AspectRatio

    public let rawValue: String
    public var aspectSize: Size {
        return Self.associatedAspects[self]!
    }

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    // RawRepresentable
    public init?(rawValue: String) { self.init(rawValue) }
}

extension AspectRatio {
    public static let square = AspectRatio("square")
    public static let ratio3to2 = AspectRatio("ratio3to2")
    public static let ratio5to3 = AspectRatio("ratio5to3")
    public static let ratio4to3 = AspectRatio("ratio4to3")
    public static let ratio5to4 = AspectRatio("ratio5to4")
    public static let ratio7to5 = AspectRatio("ratio7to5")
    public static let ratio16to9 = AspectRatio("ratio16to9")

    public static var associatedAspects: [AspectRatio: Size] = [
        .square: Size(width: 1, height: 1),
        .ratio3to2: Size(width: 3, height: 2),
        .ratio5to3: Size(width: 5, height: 3),
        .ratio4to3: Size(width: 4, height: 3),
        .ratio5to4: Size(width: 5, height: 4),
        .ratio7to5: Size(width: 7, height: 5),
        .ratio16to9: Size(width: 16, height: 9)
        ]
}
