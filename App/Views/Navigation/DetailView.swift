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
            Text("Favs")
        case .gallery:
            Text("Gallery")
        case .play:
            Text("Play")
        case .settings:
            Text("Settings")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selection: .constant(.all))
    }
}
