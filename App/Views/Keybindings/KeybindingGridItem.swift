//
//  KeybindingGridItem.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/19/22.
//

import SwiftUI

struct KeybindingGridItem: View {
    let keybinding: Keybinding
    
    var body: some View {
        VStack(spacing: 16) {
            
            GroupBox {
                Text("Test")
            }
            
            Text(keybinding.wrappedName)
        }
        .frame(maxWidth: .infinity)
    }
}

struct KeybindingGridItem_Previews: PreviewProvider {
    static var previews: some View {
        KeybindingGridItem(keybinding: Keybinding())
    }
}
