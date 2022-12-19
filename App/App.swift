//
//  KeyboardShortsApp.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/16/22.
//

import SwiftUI

@main
struct KeyboardShortsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, PersistenceManager.shared.viewContext)
            #if os(macOS)
                .frame(minWidth: 700, minHeight: 400)
            #endif
        }
        #if os(macOS)
        .defaultSize(width: 1000, height: 650)
        #endif
    }
}
