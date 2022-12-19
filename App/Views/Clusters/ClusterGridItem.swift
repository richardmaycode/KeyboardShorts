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
                .fill(KSGradientColor.allCases.randomElement()!.color)
                .frame(width: 75, height: 75, alignment: .center)
            
            Text(cluster.wrappedName)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .contextMenu {
            Button(action: { }) {
                Label("Edit", systemImage: KSSymbol.edit)
            }
            
            Button(role: .destructive, action: { } ) {
                Label("Delete", systemImage: KSSymbol.delete)
            }
        }
        .onHover { hover in
            withAnimation(.easeIn(duration: 0.25)) {
                isActive = hover
            }
        }
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
