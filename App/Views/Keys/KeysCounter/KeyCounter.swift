//
//  KeyCounter.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/24/22.
//

import SwiftUI

struct KeyCounter: View {
    
    let keysState: [Int: Bool]
    
    var body: some View {
        ZStack {
            KeyCounterBackground(totalSegments: 5)
            KeyCounterForeground(keysState: keysState, totalSegments: 5)
        }
    }
}

struct KeyCounter_Previews: PreviewProvider {
    static var previews: some View {
        KeyCounter(keysState: [:])
    }
}
