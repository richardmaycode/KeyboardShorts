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
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 300))]
    
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
        ScrollView{
            LazyVGrid(columns: columns, pinnedViews: [.sectionHeaders]) {
                ForEach(keybindings) { section in
                    Section(header: gridHeader(section.id)) {
                        ForEach(section) { record in
                            KeybindingGridItem(keybinding: record)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    fileprivate func gridHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.title)
            Spacer()
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
    
    func addRecord(name: String, summary: String, category: Category?, keys: [Key]) {
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
