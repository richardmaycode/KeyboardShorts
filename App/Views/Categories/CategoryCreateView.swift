//
//  CategoryCreateView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/25/22.
//

import SwiftUI

struct CategoryCreateView: View {
    
    @State var name: String = ""
    @State var summary: String = ""
    
    let onAdd: ((String, String) -> Void)?
    let onCancel: (() -> Void)?
    
    var body: some View {
        Form {
            TextField("name", text: $name)
            
            TextField("summary", text: $summary, axis: .vertical)
                .lineLimit(3...)
        }
        .navigationTitle("Create Category")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    onCancel?()
                } label: {
                    Text("Dismiss")
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button {
                    onAdd?(name, summary)
                } label: {
                    Text("Submit")
                }

            }
        }
    }
}

struct CategoryCreateView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCreateView(onAdd: { _,_ in }, onCancel: { })
    }
}
