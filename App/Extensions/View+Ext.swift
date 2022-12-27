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
    
    func centerView() -> some View {
        modifier(CenterView())
    }
    
    func centerAlignText() -> some View {
        modifier(CenterAlignText())
    }
    
    func scrollsAsNeeded() -> some View {
        modifier(ScrollAsNeeded())
    }
}

struct NavigationStackEmbed: ViewModifier {
    func body(content: Content) -> some View {
        NavigationStack {
            content
        }
    }
}

struct CenterView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct CenterAlignText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
    }
}

struct ScrollAsNeeded: ViewModifier {
    func body(content: Content) -> some View {
        ViewThatFits(in: .vertical) {
            content
            
            ScrollView {
                content
            }
        }
    }
}
