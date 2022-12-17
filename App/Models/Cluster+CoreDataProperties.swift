//
//  Cluster+CoreDataProperties.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//
//

import Foundation
import CoreData


extension Cluster {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cluster> {
        return NSFetchRequest<Cluster>(entityName: "Cluster")
    }

    @NSManaged public var created: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isPersonal: Bool
    @NSManaged public var modified: Date?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var keybindings: NSSet?
    @NSManaged public var categories: NSSet?

}

// MARK: Generated accessors for keybindings
extension Cluster {

    @objc(addKeybindingsObject:)
    @NSManaged public func addToKeybindings(_ value: Keybinding)

    @objc(removeKeybindingsObject:)
    @NSManaged public func removeFromKeybindings(_ value: Keybinding)

    @objc(addKeybindings:)
    @NSManaged public func addToKeybindings(_ values: NSSet)

    @objc(removeKeybindings:)
    @NSManaged public func removeFromKeybindings(_ values: NSSet)

}

// MARK: Generated accessors for categories
extension Cluster {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Category)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: Category)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

extension Cluster : Identifiable {
    
    public var wrappedID: String { id?.uuidString ?? "No ID Found" }
    public var wrappedName: String { name ?? "No Name Found" }
    public var wrappedCreated: Date { created ?? errorDate }
    public var wrappedModified: Date { modified ?? errorDate }

}
