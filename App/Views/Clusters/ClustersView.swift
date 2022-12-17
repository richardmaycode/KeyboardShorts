//
//  ClustersView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//

import SwiftUI

struct ClustersView: View {
    
    @FetchRequest(sortDescriptors: []) private var clusterResults: FetchedResults<Cluster>
    
    @State private var viewType: ViewType = .grid
    @State private var presentingNewCluster: Bool = false
    @State private var searchText: String = ""
    
    @Binding var selection: Panel?
    
    
    var body: some View {
        VStack {
            if clusterResults.isEmpty {
                emptyResults
            } else {
                switch viewType {
                case .grid:
                    grid
                case .list:
                    list
                }
            }
        }
        .navigationTitle("All Clusters")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Picker("View Type", selection: $viewType) {
                    ForEach(ViewType.allCases) { viewType in
                        Image(systemName: viewType.image)
                            .tag(viewType)
                    }
                }
                .pickerStyle(.inline)
            }
        }
        .sheet(isPresented: $presentingNewCluster) {
            NewClusterView()
                .embedInNavigationStack()
        }
        .searchable(text: $searchText)
    }
    
    var grid: some View {
        Text("Grid View")
    }
    
    var list: some View {
        Text("List View")
    }
    
    var emptyResults: some View {
        VStack {
            Image(systemName: KSSymbol.all)
                .font(.system(size: 84))
                .padding(.bottom, 5)
            Text("You haven't created any clusters!!")
                .font(.largeTitle)
            HStack(spacing: 20) {
                Button(action: { presentingNewCluster = true }) {
                    Text("Create Cluster")
                }
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                
                
                Button(action: { selection = .gallery }) {
                    Text("Browse Gallery")
                }
                .buttonStyle(.borderedProminent)
            }
           
        }
        
    }
}

struct ClustersView_Previews: PreviewProvider {
    static var previews: some View {
        ClustersView(selection: .constant(.all))
    }
}
