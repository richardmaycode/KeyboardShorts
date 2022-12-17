//
//  Category+CoreDataProperties.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var created: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var modified: Date?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var cluster: Cluster?
    @NSManaged public var keybindings: NSSet?

}

// MARK: Generated accessors for keybindings
extension Category {

    @objc(addKeybindingsObject:)
    @NSManaged public func addToKeybindings(_ value: Keybinding)

    @objc(removeKeybindingsObject:)
    @NSManaged public func removeFromKeybindings(_ value: Keybinding)

    @objc(addKeybindings:)
    @NSManaged public func addToKeybindings(_ values: NSSet)

    @objc(removeKeybindings:)
    @NSManaged public func removeFromKeybindings(_ values: NSSet)

}

extension Category : Identifiable {
    public var wrappedID: String { id?.uuidString ?? "No ID Found" }
    public var wrappedName: String { name ?? "No Name Found" }
    public var wrappedCreated: Date { created ?? Date() }
    public var wrappedModified: Date { modified ?? Date() }
}
