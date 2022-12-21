//
//  DetailView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/16/22.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var selection: Panel?
    
    var body: some View {
        switch selection ?? .all {
        case .all: ClustersView(selection: $selection)
            
        case .favorites:
            Text("Favs") // TODO: Explore marking lists as favorites
        case .gallery:
            Text("Gallery") // TODO: Create Gallery View
        case .play:
            Text("Play") // TODO: Create Play Gallery View
        case .settings:
            Text("Settings") // TODO: Create Settings View
        case .cluster:
            Text("Test")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selection: .constant(.all))
    }
}
