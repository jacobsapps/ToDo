//
//  ToDoError.swift
//  ToDo
//
//  Created by Jacob Bartlett on 31/05/2022.
//

import Foundation

enum ToDoError: Error {
    
    case todoNotFound
    case invalidToDo
    
    var title: String {
        switch self {
        case .todoNotFound: return String.ToDo.Error.todoNotFound
        case .invalidToDo: return String.ToDo.Error.invalidToDo
        }
    }
}
