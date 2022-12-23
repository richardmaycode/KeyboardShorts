//
//  KeySegmentsView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/22/22.
//

import SwiftUI

struct KeySegmentsView: View {
    
    let segments: [Int] = [1,2]
    let maxSegments: Int = 5
    
    var body: some View {
//        Circle()
//            .strokeBorder(lineWidth: 24, antialiased: true)
//
//            .overlay {
//
//            }
//            .padding(.horizontal)
//            .foregroundColor(Color.clear)
        
        ZStack {
            ForEach(0..<maxSegments, id: \.self) { segment in
                KeyArcView(segmentIndex: segment, totalSegments: maxSegments)
                    .rotation(Angle(degrees: -175))
                    .stroke(style: StrokeStyle(lineWidth: 7,lineCap: .round))
                //                        .stroke(Color.accentColor)
                    .fill(Color(uiColor: .quaternarySystemFill))
                
                
            }
            
            ForEach(segments, id: \.self) { segment in
                KeyArcView(segmentIndex: segment, totalSegments: maxSegments)
                    .rotation(Angle(degrees: -175))
                    .stroke(style: StrokeStyle(lineWidth: 7,lineCap: .round))
                //                        .stroke(Color.accentColor)
                    .fill(Color.accentColor)
                
                
            }
        }
        .padding(.horizontal)
        .overlay {
            Text("\(maxSegments - segments.count)")
        }
    }
}

struct KeySegmentsView_Previews: PreviewProvider {
    static var previews: some View {
        KeySegmentsView()
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
