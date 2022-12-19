//
//  Keybinding+CoreDataClass.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//
//

import Foundation
import CoreData

@objc(Keybinding)
public class Keybinding: NSManagedObject {
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
        created = Date()
        modified = Date()
    }
    
    override public func didSave() {
        modified = Date()
    }
    
    @objc var keybindingCategoryName: String {
        return self.category?.wrappedName ?? "No Category"
    }
}
