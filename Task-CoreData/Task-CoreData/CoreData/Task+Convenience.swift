//
//  Task+Convenience.swift
//  Task-CoreData
//
//  Created by Ali Dinç on 27/07/2021.
//

import CoreData

extension Task {
    
    @discardableResult
    convenience init(name: String, notes: String?, dueDate: Date?, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
}

