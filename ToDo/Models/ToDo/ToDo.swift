//
//  ToDo.swift
//  ToDo
//
//  Created by Jacob Bartlett on 30/05/2022.
//

import Foundation

struct ToDo: Identifiable, Equatable {
    
    var id: String = UUID().uuidString
    var title: String
    var isComplete: Bool = false
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        lhs.id == rhs.id
    }
}

extension Collection where Element == ToDo {
    
    /// Finds the Collection's index of a ToDo item in the collection
    ///
    subscript(indexOf todo: ToDo) -> Index? {
        firstIndex(where: { $0 == todo })
    }
}
