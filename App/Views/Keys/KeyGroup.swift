//
//  KeyGroup.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/21/22.
//

import SwiftUI

struct KeyGroup: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Binding var keys: [Key]
    
    var body: some View {
        HStack {
            ForEach(keys) { key in
                KeyGroupItem(key: key)
                    .onTapGesture {
                        if let keyIndex = keys.firstIndex(of: key) {
                            keys.remove(at: keyIndex)
                        }
                    }
            }
        }
        .frame(minHeight: 100)
        .padding()
        .background {
            Capsule()
                .fill(Color(uiColor: .quaternarySystemFill))
                .frame(width: CGFloat(keys.count * 250 - (keys.count * 125)))
                
        }
        
    }
}

struct KeyGroup_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceManager.preview.viewContext
        var count = 1
        let keys = ["command", "shift", "escape"]
        var previewKeys = [Key]()
        for key in keys {
            let newKey = Key(context: viewContext)
            newKey.id = Int32(count)
            newKey.name = key.uppercased()
            newKey.output = key
            newKey.isIcon = true
            
            count += 1
            previewKeys.append(newKey)
        }
        
        return KeyGroup(keys: .constant(previewKeys))
            .previewLayout(.fixed(width: 500, height: 300))
    }
}
