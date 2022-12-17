//
//  Cluster+CoreDataClass.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/17/22.
//
//

import Foundation
import CoreData

@objc(Cluster)
public class Cluster: NSManagedObject {
    lazy var errorDate: Date = Calendar.current.date(byAdding: .day, value: -4444, to: Date())!
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
        created = Date()
        modified = Date()
    }
    
    override public func willSave() {
        modified = Date()
    }
}
