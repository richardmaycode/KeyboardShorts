//
//  Category+CoreDataClass.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {
    override public func awakeFromInsert() {
        id = UUID()
        created = Date()
        modified = Date()
    }
    
    override public func didSave() {
        modified = Date()
    }
}
