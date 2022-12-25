//
//  KeyCounterBackground.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/24/22.
//

import SwiftUI

struct KeyCounterBackground: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let totalSegments: Int
    
    private var degreesPerSegment: Double {
        360.0 / Double(totalSegments)
    }
    
    private var segmentsArray: [Int] { Array(0..<totalSegments)
    }
        
    fileprivate func startAngle(for index: Int) -> Angle {
        Angle(degrees: degreesPerSegment * Double(index) + 20.0)
    }
    
    fileprivate func endAngle(for index: Int) -> Angle {
        Angle(degrees: startAngle(for: index).degrees + degreesPerSegment - 20.0)
    }
    
    var body: some View {
        GeometryReader { proxy in
            let diameter = min(proxy.size.width, proxy.size.height)
            let radius = diameter / 2.0
            let localSpace = proxy.frame(in: .local)
            let center = CGPoint(x: localSpace.midX, y: localSpace.midY)
            
            ForEach(segmentsArray, id: \.self) { segment in
                Path { path in
                    path.addArc(center: center, radius: radius, startAngle: startAngle(for: segment), endAngle: endAngle(for: segment), clockwise: false)
                }
                .stroke(style: StrokeStyle(lineWidth: 5,lineCap: .round))
                .fill(colorScheme == .dark ? Color(uiColor: .tertiarySystemBackground) : .secondary)
            }
        }
        .padding(.horizontal, 30)
        .frame(width: 100, height: 100, alignment: .center)
        .rotationEffect(Angle(degrees: -100))
    }
}

struct KeyCounterBackground_Previews: PreviewProvider {
    static var previews: some View {
        KeyCounterBackground(totalSegments: 5)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}

