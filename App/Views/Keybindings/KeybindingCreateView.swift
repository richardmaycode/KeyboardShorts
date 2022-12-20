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
    @FetchRequest(sortDescriptors: [])
    private var availableKeys: FetchedResults<Key>
    
    
    let cluster: Cluster
    let onAdd: ((String, String, Category?, [Key]) -> Void)?
    let onCancel: (() -> Void)?
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 100))]
    
    init(cluster: Cluster, onAdd: ( (String, String, Category?, [Key]) -> Void)?, onCancel: ( () -> Void)?) {

        _categories = FetchRequest<Category>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "cluster == %@", cluster)
        )
        self.cluster = cluster
        self.onAdd = onAdd
        self.onCancel = onCancel
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $name)
                
                TextField("summary", text: $summary, axis: .vertical)
                    .lineLimit(3...)
                
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
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(availableKeys) { key in
                            KeysGridItem(key: key)
                                .onTapGesture {
                                    keys.append(key)
                                }
                        }
                    }
                }
                .frame(maxHeight: 375)
                

                
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
            
            Spacer()
            Text("Binding Example")
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            HStack {
                ForEach(keys) { key in
                    KeyGroupItem(key: key)
                }
            }
            .padding()
            .frame(minWidth: 200, maxWidth: 400, maxHeight: 100)
            .background {
                Capsule()
                    .fill(Color(uiColor: .quaternarySystemFill))
            }
            
            Spacer()
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
