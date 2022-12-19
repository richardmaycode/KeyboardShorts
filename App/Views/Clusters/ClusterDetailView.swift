//
//  ClusterDetailView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/18/22.
//

import SwiftUI

struct ClusterDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let cluster: Cluster
    @State var count: Int = 1
    
    @SectionedFetchRequest
    private var keybindings: SectionedFetchResults<String, Keybinding>
    
    @State var viewType: ViewType = .grid
    @State var presentingAddKeybinding: Bool = false
    @State var presentingAddSection: Bool = false
    
    let columns: [GridItem] = [GridItem(.flexible(minimum: 100))]
    
    init(cluster: Cluster) {
        self.cluster = cluster
        _keybindings = SectionedFetchRequest<String, Keybinding>(
            sectionIdentifier: \.keybindingCategoryName,
            sortDescriptors: [],
            predicate: NSPredicate(format: "cluster == %@", cluster)
        )
    }
    
    var body: some View {
        VStack {
            if viewType == .grid {
                grid
            } else {
                List(keybindings) { section in
                    Section(header: Text(section.id)) {
                        ForEach(section) { record in
                            Text(record.wrappedName)
                        }
                    }
                }
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
            }
            
            
            
        }
        .sheet(isPresented: $presentingAddKeybinding) {
            NavigationStack {
                KeybindingCreateView(cluster: cluster, onAdd: { name, summary, category, keys in
                    addRecord(name: name, summary: summary, category: category, keys: keys)
                    presentingAddKeybinding = false
                }, onCancel: { presentingAddKeybinding = false })
            }
        }
        .sheet(isPresented: $presentingAddSection) {
            NavigationStack {
                Text("Add Section Form")
                    .navigationTitle("Add Section")
                    .toolbar {
                        Button(action: { addCategory() }) {
                            Text("Add")
                        }
                    }
            }
        }

            

        
    }
    
    var grid: some View {
        LazyVGrid(columns: columns) {
            ForEach(keybindings) { section in
                Section(header: Text(section.id)) {
                    ForEach(section) { record in
                        KeybindingGridItem(keybinding: record)
                    }
                }
            }
        }
    }
    
    
    func addRecord(name: String, summary: String, category: String, keys: [Key]) {
        let keybinding = Keybinding(context: viewContext)
        keybinding.name = name
        keybinding.summary = summary
        
        for key in keys {
            keybinding.addToKeys(key)
        }
        
        if category != "No Category" {
            
        }
        
        cluster.addToKeybindings(keybinding)
        
        do {
            try viewContext.save()
            count += 1
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addCategory() {
        let categories = ["Test", "Test2", "Test3", "Test4"]
        
        for category in categories {
            let newCategory = Category(context: viewContext)
            newCategory.name = category
            cluster.addToCategories(newCategory)
        }
        
        do {
            try viewContext.save()
            presentingAddSection = false
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ClusterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClusterDetailView(cluster: Cluster())
    }
}
