//
//  ContentView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/16/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: Panel? = .all
    
    var body: some View {
        NavigationSplitView {
            Sidebar(selection: $selection)
        } detail: {
            NavigationStack {
                DetailView(selection: $selection)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
