//
//  KeyCounterForeground.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/24/22.
//

import SwiftUI

struct KeyCounterForeground: View {
    
    let keysState: [Int: Bool]
    let totalSegments: Int
    
    private var degreesPerSegment: Double {
        360.0 / Double(totalSegments)
    }
    
    private var segmentsArray: [Int] {
        Array(0..<totalSegments)
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
            
            ForEach(keysState.sorted { $0.0 > $1.0 }, id: \.key) { key, value in
                Path { path in
                    path.addArc(center: center, radius: radius, startAngle: startAngle(for: key), endAngle: endAngle(for: key), clockwise: false)
                }
                .trim(from: 0, to: value ? 1.0 : .zero)
                .stroke(style: StrokeStyle(lineWidth: 5,lineCap: .round))
                .fill(Color.accentColor)
                .animation(.linear(duration: 0.25), value: value) // FIXME: First animation does not run correctly
            }
        }
        .padding(.horizontal, 30)
        .frame(width: 100, height: 100, alignment: .center)
        .rotationEffect(Angle(degrees: -100))
    }
}

struct KeyCounterForeground_Previews: PreviewProvider {
    static var previews: some View {
        KeyCounterForeground(keysState: [:], totalSegments: 5)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
