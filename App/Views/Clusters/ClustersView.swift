//
//  ClustersView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//

import SwiftUI

struct ClustersView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.isFavorite, order: .reverse),SortDescriptor(\.name)]) private var clusterResults: FetchedResults<Cluster>
    
    @State private var viewType: ViewType = .grid
    @State private var presentingNewCluster: Bool = false
    @State private var searchText: String = ""
    
    @Binding var selection: Panel?
    
    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            searchText = newValue
            clusterResults.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "name CONTAINS %@", newValue)
        }
    }
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        VStack {
            if clusterResults.isEmpty {
                if !searchText.isEmpty {
                    emptySearch
                } else {
                    emptyResults
                }
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
            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: { presentingNewCluster = true }) {
                    Label("Add Cluster", systemImage: KSSymbol.add)
                        .labelStyle(.iconOnly)
                }
                
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
            ClusterCreateView(onAdd: { name, summary, isPersonal in
                presentingNewCluster = false
                createCluster(name: name, summary: summary, isPersonal: isPersonal)
            }, onCancel: { presentingNewCluster = false })
            .embedInNavigationStack()
        }
        .searchable(text: query)
        .navigationDestination(for: Cluster.self) { cluster in
            ClusterDetailView(cluster: cluster)
        }
    }
    
    var grid: some View {
        Group {
            LazyVGrid(columns: columns) {
                ForEach(clusterResults) { cluster in
                    NavigationLink(value: cluster) {
                        ClusterGridItem(cluster: cluster, onFavorite: { cluster in toggleFavorite(for: cluster)})
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(24)
            
            Spacer()
        }
    }
    
    var list: some View {
        Text("Table") // FIXME: Fix complier error
//        Table(clusterResults) {
//            TableColumn("Name", value: \.wrappedName)
//            TableColumn("Summary") { cluster in
//                Text(cluster.summary ?? "")
//            }
//            TableColumn("Custom Cluster") { cluster in
//                Text(cluster.isPersonal ? "Yes" : "No")
//            }
//            TableColumn("Created") { cluster in
//                Text(cluster.wrappedCreated.formatted(date: .numeric, time: .shortened))
//            }
//            TableColumn("Modified") { cluster in
//                Text(cluster.wrappedModified.formatted(date: .numeric, time: .shortened))
//            }
//        }
    }
    
    var emptyResults: some View {
        VStack(spacing: 16) {
            Image(systemName: KSSymbol.all)
                .font(.system(size: 64))
                .padding(.bottom, 5)
            
            Text("You haven't created any clusters!")
                .font(.largeTitle)
            
            Text("Clusters are groups of keyboard shortcuts, you can group them by program, use case, or just put your favorites together.")
                .multilineTextAlignment(.center)
                .lineLimit(2, reservesSpace: true)
                .frame(maxWidth: 500)
            
            
            HStack(spacing: 20) {
                Button(action: { presentingNewCluster = true }) {
                    Text("Create Cluster")
                }
                .buttonStyle(.borderedProminent)
                
                
                Button(action: { selection = .gallery }) {
                    Text("Browse Gallery")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    var emptySearch: some View {
        VStack(spacing: 16) {
            Image(systemName: KSSymbol.search)
                .font(.system(size: 64))
                .padding(.bottom, 5)
            
            Text("No Results")
                .font(.largeTitle)
            
            Text("We couldn't find any clusters using with that name.")
                .multilineTextAlignment(.center)
                .lineLimit(2, reservesSpace: true)
                .frame(maxWidth: 500)
        }
    }
    
    func toggleFavorite(for cluster: Cluster) {
        cluster.isFavorite = !cluster.isFavorite
        
        do {
            try viewContext.save()
        } catch {
            // TODO: Handle Error with Alert
            print(error.localizedDescription)
        }
    }
    
    func createCluster(name: String, summary: String, isPersonal: Bool) {
        let cluster = Cluster(context: viewContext)
        cluster.name = name
        cluster.summary = summary
        cluster.isPersonal = isPersonal
        
        do {
            try viewContext.save()
        } catch {
            // TODO: Handle Error with Alert
            print(error.localizedDescription)
        }
    }
}

struct ClustersView_Previews: PreviewProvider {
    static var previews: some View {
        ClustersView(selection: .constant(.all))
    }
}
