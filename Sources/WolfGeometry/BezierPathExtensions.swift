//
//  BezierPathExtensions.swift
//  WolfGeometry
//
//  Created by Wolf McNally on 7/2/15.
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
import WolfFoundation

#if canImport(AppKit)
    import AppKit
#elseif canImport(UIKit)
    import UIKit
#endif

#if os(macOS)
    extension OSBezierPath {
        public func addLine(to point: CGPoint) {
            line(to: point)
        }

        public func addArcWithCenter(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
            appendArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle)
        }
    }
#endif

extension OSBezierPath {
    public func addClosedPolygon(withPoints points: [CGPoint]) {
        for (index, point) in points.enumerated() {
            switch index {
            case 0:
                move(to: point)
            default:
                addLine(to: point)
            }
        }
        close()
    }

    public convenience init(closedPolygon: [CGPoint]) {
        self.init()
        addClosedPolygon(withPoints: closedPolygon)
    }
}

#if os(macOS)
    extension NSBezierPath {
        public convenience init (arcCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
            self.init()
            appendArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        }

        public var cgPath: CGPath {
            let path = CGMutablePath()
            let elementsCount = self.elementCount

            let pointsArray = NSPointArray.allocate( capacity: 3 )

            for index in 0 ..< elementsCount {
                switch element( at: index, associatedPoints: pointsArray ) {
                case .moveTo:
                    path.move(to: pointsArray[0])

                case .lineTo:
                    path.addLine(to: pointsArray[0])

                case .curveTo:
                    path.addCurve(to: pointsArray[0], control1: pointsArray[1], control2: pointsArray[2])

                case .closePath:
                    path.closeSubpath()

                @unknown default:
                    fatalError()
                }
            }

            return path.copy()!
        }
    }
#endif

extension OSBezierPath {
    public convenience init(sides: Int, radius: CGFloat, center: CGPoint = .zero, rotationAngle: CGFloat = 0.0, cornerRadius: CGFloat = 0.0) {

        self.init()

        let theta = 2 * .pi / Double(sides)
        let r = Double(radius)

        var corners = [CGPoint]()
        for side in 0 ..< sides {
            let alpha = Double(side) * theta + Double(rotationAngle)
            let cornerX = cos(alpha) * r + Double(center.x)
            let cornerY = sin(alpha) * r + Double(center.y)
            let corner = CGPoint(x: cornerX, y: cornerY)
            corners.append(corner)
        }

        if cornerRadius <= 0.0 {
            for (index, corner) in corners.enumerated() {
                if index == 0 {
                    move(to: corner)
                } else {
                    addLine(to: corner)
                }
            }
        } else {
            for index in 0 ..< corners.count {
                let o = Point(corners[index])
                let p1 = Point(corners.element(atCircularIndex: index - 1))
                let p2 = Point(corners.element(atCircularIndex: index + 1))
                let (center, startPoint, startAngle, _ /*endPoint*/, endAngle, clockwise) = infoForRoundedCornerArcAtVertex(withRadius: Double(cornerRadius), o: o, p1, p2)
                if index == 0 {
                    move(to: CGPoint(startPoint))
                }
                #if os(macOS)
                    addArcWithCenter(center: CGPoint(center), radius: cornerRadius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise)
                #else
                    addArc(withCenter: CGPoint(center), radius: cornerRadius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise)
                #endif
            }
        }
        close()
    }
}
