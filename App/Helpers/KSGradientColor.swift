//
//  GradientColor.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/18/22.
//

import SwiftUI

enum KSGradientColor: Int, CaseIterable {
    case red, orange, yellow, green, blue, purple, indigo, pink
    
    var id: Int { self.rawValue }
    
    var color: AnyGradient {
        switch self {
        case .red:
            return Color.red.gradient
        case .orange:
            return Color.orange.gradient
        case .yellow:
            return Color.yellow.gradient
        case .green:
            return Color.green.gradient
        case .blue:
            return Color.blue.gradient
        case .purple:
            return Color.purple.gradient
        case .indigo:
            return Color.indigo.gradient
        case .pink:
            return Color.pink.gradient
        }
    }
}
