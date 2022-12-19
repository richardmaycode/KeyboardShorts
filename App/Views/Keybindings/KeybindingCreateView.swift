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
    
    @FetchRequest(sortDescriptors: []) private var categories: FetchedResults<Category>
    
    
    let cluster: Cluster
    let onAdd: ((String, String, String, [Key]) -> Void)?
    let onCancel: (() -> Void)?
    
    init(cluster: Cluster, onAdd: ( (String, String, String, [Key]) -> Void)?, onCancel: ( () -> Void)?) {

        _categories = FetchRequest<Category>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "cluster == %@", cluster)
        )
        self.cluster = cluster
        self.onAdd = onAdd
        self.onCancel = onCancel
    }
    
    var body: some View {
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
        }
        .navigationTitle("Create Keybinding")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: { onCancel?() } ) {
                    Text("Dismiss")
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button(action: { onAdd?(name, summary, category, keys) }) {
                    Text("Submit")
                }
            }
        }
    }
}

struct KeybindingCreateView_Previews: PreviewProvider {
    static var previews: some View {
        KeybindingCreateView(cluster: Cluster(), onAdd: { _,_,_,_ in }, onCancel: { })
    }
}
