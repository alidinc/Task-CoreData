//
//  Date+Extension.swift
//  Task-CoreData
//
//  Created by Ali Dinç on 28/07/2021.
//

import Foundation


extension Date {
    
    func dateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
