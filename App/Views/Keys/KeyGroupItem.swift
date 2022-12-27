//
//  KeyGroupItem.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/20/22.
//

import SwiftUI

struct KeyGroupItem: View {
    @Environment(\.colorScheme) private var colorScheme
    let key: Key
    
    var body: some View {
        Group {
            if key.isIcon {
                Image(systemName: key.wrappedOutput)
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                    .fontWeight(colorScheme == .dark ? .regular : .bold)
            } else {
                Text(key.wrappedOutput)
            }
        }
        .frame(width: 55, height: 55)
        .padding()
        .background {
            Circle()
            #if os(iOS)
                .fill(Color(uiColor: .quaternarySystemFill)) // FIXME: Add color for MacOS
            #endif

        }
        .padding(5)
    }
}

struct KeyGroupItem_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceManager.preview.viewContext
        let key = Key(context: viewContext)
        key.id = 1
        key.name = "Command"
        key.output = "command"
        key.isIcon = true
        
        return KeyGroupItem(key: key)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
