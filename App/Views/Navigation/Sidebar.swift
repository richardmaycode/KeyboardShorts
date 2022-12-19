//
//  Sidebar.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/16/22.
//

import SwiftUI

enum Panel: Int, Hashable, Identifiable, CaseIterable {
    case all, favorites, gallery, play, settings, cluster
    
    var id: Int { rawValue }
    
    var localizedName: LocalizedStringKey {
        switch self {
        case .all:
            return "All"
        case .favorites:
            return "Favorites"
        case .gallery:
            return "Gallery"
        case .play:
            return "Play"
        case .settings:
            return "Settings"
        case .cluster:
            return ""
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            return KSSymbol.all
        case .favorites:
            return KSSymbol.favorite
        case .gallery:
            return KSSymbol.gallery
        case .play:
            return KSSymbol.game
        case .settings:
            return KSSymbol.settings
        case .cluster:
            return ""
        }
    }
}


struct Sidebar: View {
    
    @Binding var selection: Panel?
    
    var body: some View {
        List(selection: $selection) {
            ForEach(Panel.allCases) { panel in
                if panel.rawValue != 5{
                    NavigationLink(value: panel) {
                        Label(panel.localizedName, systemImage: panel.icon)
                    }
                    .tag(panel)
                }
            }
        }
        .navigationTitle("Board Shorts")
        #if os(macOS)
        .navigationSplitViewColumnWidth(min: 150, ideal: 150, max: 175)
        #endif
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(selection: .constant(.all))
    }
}
