//
//  KeysGridItem.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/20/22.
//

import SwiftUI

struct KeysGridItem: View {
    
    let key: Key
    
    var body: some View {
        VStack(spacing: 8) {
            // TODO: Export style to custom modifier
            if key.isIcon {
                Image(systemName: key.wrappedOutput)
                    .frame(width: 75, height: 75, alignment: .center)
                    .background {
                        Circle()
                            .fill(.gray.opacity(0.2))
                    }
            } else {
                Text(key.wrappedOutput)
                    .frame(width: 75, height: 75, alignment: .center)
                    .background {
                        Circle()
                            .fill(.gray.opacity(0.2))
                    }
            }
            
            Text(key.wrappedName)
        }

    }
}

struct KeysGridItem_Previews: PreviewProvider {
    static var previews: some View {
        KeysGridItem(key: Key())
    }
}
