//
//  Key+CoreDataProperties.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//
//

import Foundation
import CoreData


extension Key {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Key> {
        return NSFetchRequest<Key>(entityName: "Key")
    }

    @NSManaged public var created: Date?
    @NSManaged public var id: Int32
    @NSManaged public var modified: Date?
    @NSManaged public var name: String?
    @NSManaged public var output: String?
    @NSManaged public var isIcon: Bool
    @NSManaged public var keybindings: NSSet?

}

// MARK: Generated accessors for keybindings
extension Key {

    @objc(addKeybindingsObject:)
    @NSManaged public func addToKeybindings(_ value: Keybinding)

    @objc(removeKeybindingsObject:)
    @NSManaged public func removeFromKeybindings(_ value: Keybinding)

    @objc(addKeybindings:)
    @NSManaged public func addToKeybindings(_ values: NSSet)

    @objc(removeKeybindings:)
    @NSManaged public func removeFromKeybindings(_ values: NSSet)

}

extension Key : Identifiable {
    public var wrappedName: String { name ?? "Unknown"}
    public var wrappedOutput: String { output ?? "puzzlepiece"}

    
    public var wrappedCreated: Date { created ?? Date() }
    
    public var wrappedModified: Date { modified ?? Date() }
    
}
