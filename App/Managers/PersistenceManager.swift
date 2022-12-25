//
//  PersistenceManager.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/16/22.
//

import CoreData

class PersistenceManager {
    static let shared = PersistenceManager()
    private var container: NSPersistentContainer
    
    static var preview: PersistenceManager = {
        let manager = PersistenceManager(inMemory: true)
        
        return manager
    }()
    
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: KSStrings.datastore)
        container.loadPersistentStores { description, error in
            if let error { fatalError(KSErrors.initCoreDataFailed + " Error: \(error)") }
        }
        
        let fetchRequest: NSFetchRequest<Key>
        fetchRequest = Key.fetchRequest()
        
        do {
            
            let objects = try viewContext.fetch(fetchRequest)
            // MARK: Generate All Keyboard Items
            if objects.isEmpty {
                for key in KeyReference.data {
                    let newKey = Key(context: viewContext)
                    newKey.id = Int32(key.id)
                    newKey.name = key.name
                    newKey.output = key.output
                    newKey.isIcon = key.isSymbol
                }
                
                
            }
            
            // MARK: Generate All Missing Items
            if objects.count != KeyReference.data.count {
                for key in KeyReference.data {
                    if !objects.contains(where: { $0.id == key.id }) {
                        let newKey = Key(context: viewContext)
                        newKey.id = Int32(key.id)
                        newKey.name = key.name
                        newKey.output = key.output
                        newKey.isIcon = key.isSymbol
                    }
                }
            }
        } catch {
            print(error.localizedDescription) // TODO: Handle this Error
        }
    }
    
    var viewContext: NSManagedObjectContext { container.viewContext }
    
    func previewCluster() -> Cluster {
        let previewCluster = Cluster(context: Self.preview.viewContext)
        previewCluster.name = "Xcode Preview"
        previewCluster.summary = "Cluster provided for testing of views *DEVELOPMENT ONLY*"
        
        return previewCluster
    }
}
