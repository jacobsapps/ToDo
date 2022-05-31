//
//  Filter.swift
//  ToDo
//
//  Created by Jacob Bartlett on 30/05/2022.
//

import SwiftUI

enum Filter: CaseIterable {
    case all
    case active
    case completed
    
    var text: String {
        switch self {
        case .all: return String.ToDo.FilterButton.all
        case .active: return String.ToDo.FilterButton.active
        case .completed: return String.ToDo.FilterButton.completed
        }
    }
}

extension Array where Element == ToDo {
    
    func filtered(with filter: Filter) -> [ToDo] {
        switch filter {
        case .all: return self
        case .active: return self.filter { !$0.isComplete }
        case .completed: return self.filter { $0.isComplete }
        }
    }
}
