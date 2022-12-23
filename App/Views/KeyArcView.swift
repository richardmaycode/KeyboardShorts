//
//  KeyArcView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/22/22.
//

import SwiftUI

struct KeyArcView: Shape {
    let segmentIndex: Int
    let totalSegments: Int

    
    private var degreesPerSegment: Double {
        360.0 / Double(totalSegments)
    }
    
    private var startAngle: Angle {
        Angle(degrees: degreesPerSegment * Double(segmentIndex) + 20.0)
    }
    
    private var endAngle: Angle {
        Angle(degrees: startAngle.degrees + degreesPerSegment - 20.0)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height)
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)

        }
    }
}
