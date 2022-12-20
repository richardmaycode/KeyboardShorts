//
//  KeyGroupItem.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/20/22.
//

import SwiftUI

struct KeyGroupItem: View {
    
    let key: Key
    
    var body: some View {
        Group {
            if key.isIcon {
                Image(systemName: key.wrappedOutput)
            } else {
                Text(key.wrappedOutput)
            }
        }
        .frame(width: 75, height: 75)
        .padding()
        .background {
            Circle()
                .fill(Color(uiColor: .quaternarySystemFill))
                .padding()
        }
    }
}

struct KeyGroupItem_Previews: PreviewProvider {
    static var previews: some View {
        KeyGroupItem(key: Key())
    }
}
