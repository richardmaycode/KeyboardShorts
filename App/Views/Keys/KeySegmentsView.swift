//
//  KeySegmentsView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/22/22.
//

import SwiftUI

struct KeySegmentsView: View {
    
    let segments: [Int]
    let maxSegments: Int = 5
    
    var body: some View {

        ZStack {
            ForEach(0..<maxSegments, id: \.self) { segment in
                KeyArcView(segmentIndex: segment, totalSegments: maxSegments)
                    .rotation(Angle(degrees: -175))
                    .stroke(style: StrokeStyle(lineWidth: 4,lineCap: .round))
                    .fill(Color(uiColor: .quaternarySystemFill))
                
                
            }
            .overlay {
                Text("\(maxSegments - segments.count)")
            }
            
            ForEach(segments, id: \.self) { segment in
                KeyArcView(segmentIndex: segment, totalSegments: maxSegments)
                    .rotation(Angle(degrees: -105))
                    .stroke(style: StrokeStyle(lineWidth: 4,lineCap: .round))
                    .fill(Color.accentColor)
                
                
            }
        }
        .padding(.horizontal)
        .frame(width: 75, height: 75)

    }
}

struct KeySegmentsView_Previews: PreviewProvider {
    static var previews: some View {
        KeySegmentsView(segments: [1,2])
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
