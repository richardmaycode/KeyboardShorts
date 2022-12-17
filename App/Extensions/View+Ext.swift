//
//  View+Ext.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//

import SwiftUI

extension View {
    func embedInNavigationStack() -> some View {
        modifier(NavigationStackEmbed())
    }
}

struct NavigationStackEmbed: ViewModifier {
    func body(content: Content) -> some View {
        NavigationStack {
            content
        }
    }
}
