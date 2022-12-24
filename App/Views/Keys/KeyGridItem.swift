//
//  KeysGridItem.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/20/22.
//

import SwiftUI

struct KeysGridItem: View {
    
    let key: Key
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            if key.isIcon {
                Image(systemName: key.wrappedOutput)
                    .font(.title)

            } else {
                Text(key.wrappedOutput)
            }
        }
        
        .frame(width: 50, height: 50)
        .padding()
        .overlay {
            Circle()
                .fill(isSelected ? Color.accentColor.opacity(0.3) : .clear)
        }
        .foregroundColor(isSelected ? .accentColor : .primary)
        .fontWeight(isSelected ? .bold : .regular)

    }
}

struct KeysGridItem_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceManager.preview.viewContext
        let key = Key(context: viewContext)
        key.id = 1
        key.name = "Command"
        key.output = "command"
        key.isIcon = true
        
        return KeysGridItem(key: key, isSelected: true)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
