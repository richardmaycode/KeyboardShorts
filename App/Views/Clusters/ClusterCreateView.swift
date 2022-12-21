//
//  NewClusterView.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//

import SwiftUI

struct ClusterCreateView: View {
    
    @State var name: String = ""
    @State var summary: String = ""
    
    let onAdd: ((String, String, Bool) -> Void)?
    let onCancel: (() -> Void)?
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Summary", text: $summary)
        }
        .navigationTitle("Create Cluster")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss", action: { onCancel?() })
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Submit", action: { onAdd?(name, summary, true) })
                    .disabled(!validForm())
            }
        }
        #if os(macOS)
        .frame(width: 400, height: 100)
        .padding()
        #endif
    }
    
    func validForm() -> Bool {
        validName()
    }
    
    func validName() -> Bool {
        name.filter { !$0.isWhitespace }.count > 3
    }
}

struct ClusterCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ClusterCreateView(onAdd: { _,_,_ in return }, onCancel: { })
            .embedInNavigationStack()
    }
}
