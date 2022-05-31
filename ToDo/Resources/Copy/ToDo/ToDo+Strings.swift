//
//  ToDo+Strings.swift
//  ToDo
//
//  Created by Jacob Bartlett on 30/05/2022.
//

import Foundation

/// Expose strongly-typed string types that can be edited from one place
/// Raw strings should ideally reside in a strings table in each feature module for easy localisation
///
extension String {
    struct ToDo {}
}

extension String.ToDo {
    
    static var header = "TODO"
    
    struct Error {
        static var error = "Error"
        static var ok = "OK"
        static var todoNotFound = "Error: The todo was not found"
        static var invalidToDo = "Error: You need to enter a valid title for a todo"
    }
    
    struct Table {
        static var createANewToDo = "Create a new todo..."
        static var clearCompleted = "Clear Completed"
        static var xItemsLeft = "$0 items left"
        static var dragAndDropToReorderList = "Drag and drop to reorder list"
    }
    
    struct FilterButton {
        static var all = "All"
        static var active = "Active"
        static var completed = "Completed"
    }
}
