//
//  KeybindingCreateView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/19/22.
//

import SwiftUI

struct KeybindingCreateView: View {
    
    @State var name: String = ""
    @State var summary: String = ""
    @State var keys: [Key] = []
    @State var category: String = "No Category"
    @State var selectedCategory: Category?
    @State var keySearchText: String = ""
    
    @FetchRequest(sortDescriptors: [])
    private var categories: FetchedResults<Category>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.isIcon, order: .reverse)])
    private var availableKeys: FetchedResults<Key>
    
    
    let cluster: Cluster
    let onAdd: ((String, String, Category?, [Key]) -> Void)?
    let onCancel: (() -> Void)?
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 100))]
    
    init(cluster: Cluster, onAdd: ( (String, String, Category?, [Key]) -> Void)?, onCancel: ( () -> Void)?) {
        
        _categories = FetchRequest<Category>(
            sortDescriptors: [SortDescriptor(\.name)],
            predicate: NSPredicate(format: "cluster == %@", cluster)
        )
        self.cluster = cluster
        self.onAdd = onAdd
        self.onCancel = onCancel
    }
    
    // TODO: Move views to subviews
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $name)
                
                TextField("summary", text: $summary, axis: .vertical)
                    .lineLimit(3...)
                
                // TODO: Add ability to create category while on the new keybinding screen
                Picker("Category", selection: $category) {
                    Text("No Category")
                        .tag("No Category")
                    ForEach(categories) { category in
                        Text(category.wrappedName)
                            .tag(category.wrappedName)
                    }
                }
                .onChange(of: category) { newValue in
                    guard category != "No Category" else {
                        selectedCategory = nil
                        return
                    }
                    
                    selectedCategory = categories.first { $0.wrappedName == newValue }
                }
                
                TextField("Search", text: $keySearchText)
                    
                
                // TODO: Extract to subview
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(availableKeys.filter { $0.wrappedName.hasPrefix(keySearchText) })  { key in
                            let inSelection = keys.contains(key)
                            KeysGridItem(key: key, isSelected: inSelection)
                                .onTapGesture {
                                    guard !keys.contains(key) else { keys.removeAll(where: { $0 == key})
                                        return
                                    }
                                    if keys.count < 5 {
                                        keys.append(key)
                                    }
                                }
                        }
                    }
                }
                .frame(maxHeight: 250)
            }
            
            Spacer()
            
            Text("Binding Example")
                
                .font(.system(.title, design: .monospaced, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
            
            KeyGroup(keys: $keys)
                .frame(minHeight: 175, maxHeight: 175)
            Spacer()
        }
        .navigationTitle("Create Keybinding")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: { onCancel?() } ) {
                    Text("Dismiss")
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button(action: { onAdd?(name, summary, selectedCategory, keys) }) {
                    Text("Submit")
                }
                .disabled(!validForm())
            }
        }
    }
    
    
    func validForm() -> Bool {
        validKeys() && validName()
    }
    
    func validName() -> Bool {
        name.filter { !$0.isWhitespace}.count > 3
    }
    
    func validKeys() -> Bool {
        keys.count > 0
    }
}

struct KeybindingCreateView_Previews: PreviewProvider {
    static var previews: some View {
        KeybindingCreateView(cluster: Cluster(), onAdd: { _,_,_,_ in }, onCancel: { })
    }
}
