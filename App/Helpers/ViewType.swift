//
//  ViewType.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//

import Foundation

enum ViewType: Int, CaseIterable, Identifiable {
    case grid, list
    
    var id: Int { rawValue }
    
    var image: String {
        switch self {
        case .grid: return "square.grid.2x2"
        case .list: return "list.triangle"
        }
    }
}
