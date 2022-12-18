//
//  ClusterGridItem.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/18/22.
//

import SwiftUI

struct ClusterGridItem: View {
    
    let cluster: Cluster
    
    @State var isActive: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16)
                .fill(.blue.gradient)
                .frame(width: 75, height: 75, alignment: .center)
            
            Text(cluster.wrappedName)
        }
        .contextMenu {
            Button(role: .destructive, action: { } ) {
                Label("Delete", systemImage: KSSymbol.delete)
            }
        }
        .onHover(perform: { hover in
            isActive = hover
        })
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(isActive ? .gray.opacity(0.2) : .clear)
                
        }
    }
}

struct ClusterGridItem_Previews: PreviewProvider {
    static var previews: some View {
        ClusterGridItem(cluster: Cluster())
    }
}
