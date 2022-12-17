//
//  Keybinding+CoreDataProperties.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//
//

import Foundation
import CoreData


extension Keybinding {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Keybinding> {
        return NSFetchRequest<Keybinding>(entityName: "Keybinding")
    }

    @NSManaged public var created: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var modified: Date?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var cluster: Cluster?
    @NSManaged public var category: Category?
    @NSManaged public var keys: NSSet?

}

// MARK: Generated accessors for keys
extension Keybinding {

    @objc(addKeysObject:)
    @NSManaged public func addToKeys(_ value: Key)

    @objc(removeKeysObject:)
    @NSManaged public func removeFromKeys(_ value: Key)

    @objc(addKeys:)
    @NSManaged public func addToKeys(_ values: NSSet)

    @objc(removeKeys:)
    @NSManaged public func removeFromKeys(_ values: NSSet)

}

extension Keybinding : Identifiable {
    public var wrappedID: String { id?.uuidString ?? "No ID Found" }
    public var wrappedName: String { name ?? "No Name Found" }
    public var wrappedCreated: Date { created ?? Date() }
    public var wrappedModified: Date { modified ?? Date() }
}
