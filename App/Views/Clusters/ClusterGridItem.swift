//
//  ClusterGridItem.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/18/22.
//

import SwiftUI

struct ClusterGridItem: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let cluster: Cluster
    let onFavorite: ((Cluster) -> Void)?
    
    @State var isActive: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16)
            
                .fill(KSGradientColor.allCases.randomElement()!.color)
                .frame(width: 75, height: 75, alignment: .center)
                .shadow(color: colorScheme == .dark ? .clear : .gray, radius: 2, x: 0, y: 2)
                .overlay {
                    if cluster.isFavorite {
                        Image(systemName: KSSymbol.favorite)
                            .symbolVariant(.fill)
                            
                            .foregroundStyle(.shadow(.inner(color: .black, radius: 1, x: 0.5, y: 1)))
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            
                    }
                }
                
            
            Text(cluster.wrappedName)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .contextMenu {
            Button(action: { onFavorite?(cluster) }) {
                Label(cluster.isFavorite ? "Unfavorite" : "Favorite", systemImage: KSSymbol.favorite)
                    .symbolVariant(cluster.isFavorite ? .slash : .none)
            }
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
        ClusterGridItem(cluster: PersistenceManager().previewCluster(), onFavorite: { _ in })
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
