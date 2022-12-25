//
//  ClusterDetailView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/18/22.
//

import SwiftUI

struct ClusterDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var viewType: ViewType = .grid
    @State var presentingAddKeybinding: Bool = false
    @State var presentingAddSection: Bool = false
    
    @SectionedFetchRequest
    private var keybindings: SectionedFetchResults<String, Keybinding>
    
    @FetchRequest
    private var emptyCategories: FetchedResults<Category>
    
    let cluster: Cluster
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 300))]
    
    init(cluster: Cluster) {
        self.cluster = cluster
        _keybindings = SectionedFetchRequest<String, Keybinding>(
            sectionIdentifier: \.keybindingCategoryName,
            sortDescriptors: [],
            predicate: NSPredicate(format: "cluster == %@", cluster)
        )
        _emptyCategories = FetchRequest<Category>(
            sortDescriptors: [SortDescriptor(\.name)],
            predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "cluster == %@", cluster),
                NSPredicate(format: "keybindings.@count == 0")
            ])
        )
    }
    
    var body: some View {
        VStack {
            if viewType == .grid {
                grid
            } else {
                list()
            }
        }
        .navigationTitle(cluster.wrappedName)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: { presentingAddKeybinding = true }) {
                    Image(systemName: KSSymbol.addBinding)
                }
                
                Button(action: { presentingAddSection = true }) {
                    Image(systemName: KSSymbol.addSection)
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
        .sheet(isPresented: $presentingAddKeybinding) {
            NavigationStack {
                KeybindingCreateView(cluster: cluster, onAdd: { name, summary, category, keys in
                    addRecord(name: name, summary: summary, category: category, keys: keys)
                }, onCancel: { presentingAddKeybinding = false })
            }
        }
        .sheet(isPresented: $presentingAddSection) {
            NavigationStack {
                CategoryCreateView(onAdd: { name, summary in addCategory(name: name, summary: summary)}, onCancel: { presentingAddSection = false })
            }
        }
    }
    
    private var grid: some View {
        ScrollView{
            LazyVGrid(columns: columns, pinnedViews: [.sectionHeaders]) {
                ForEach(keybindings) { section in
                    Section(header: gridHeader(section.id, count: 0)) { // FIXME: Add lookup for count of keybindings in category
                        ForEach(section) { record in
                            KeybindingGridItem(keybinding: record)
                        }
                    }
                }
                
                ForEach(emptyCategories) { category in
                    Section(header: gridHeader(category.wrappedName, count: category.keybindings?.count ?? 0)) {
                        Text("No Keybindings in this Category")
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    fileprivate func gridHeader(_ title: String, count: Int) -> some View {
        HStack {
            Text(title)
                .font(.title)
            Spacer()
            Text("\(count)")
        }
        .padding(10)
        .background(.thickMaterial)
    }
    
    @ViewBuilder
    fileprivate func list() -> some View {
        List(keybindings) { section in
            Section(header: Text(section.id)) {
                ForEach(section) { record in
                    Text(record.wrappedName)
                }
            }
        }
    }
    
    fileprivate func addRecord(name: String, summary: String, category: Category?, keys: [Key]) {
        let keybinding = Keybinding(context: viewContext)
        keybinding.name = name
        keybinding.summary = summary
        
        for key in keys {
            keybinding.addToKeys(key)
        }
        
        if let category = category {
            category.addToKeybindings(keybinding)
        }
        
        cluster.addToKeybindings(keybinding)
        
        do {
            presentingAddKeybinding = false
            try viewContext.save()
        } catch {
            // TODO: Handle Error with alert
            print(error.localizedDescription)
        }
    }
    
    fileprivate func addCategory(name: String, summary: String) {
        let category = Category(context: viewContext)
        category.name = name
        category.summary = summary
        
        cluster.addToCategories(category)
        
        do {
            presentingAddSection = false
            try viewContext.save()
            
        } catch {
            // TODO: Handle Error with alert
            print(error.localizedDescription)
        }
    }
}

struct ClusterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClusterDetailView(cluster: PersistenceManager().previewCluster())
            .embedInNavigationStack()
    }
}
