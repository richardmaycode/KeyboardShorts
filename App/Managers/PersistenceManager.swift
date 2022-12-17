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
    
    private init() {
        container = NSPersistentContainer(name: KSStrings.datastore)
        container.loadPersistentStores { description, error in
            if let error { fatalError(KSErrors.initCoreDataFailed + " Error: \(error)") }
        }
        
        let fetchRequest: NSFetchRequest<Key>
        fetchRequest = Key.fetchRequest()
        
        do {
            
            let objects = try viewContext.fetch(fetchRequest)
            if objects.isEmpty {
                print("No Results!!!!")
            }
        } catch {}
        

        
    }
    
    var viewContext: NSManagedObjectContext { container.viewContext }
}
