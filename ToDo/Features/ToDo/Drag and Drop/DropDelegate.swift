//
//  DropDelegate.swift
//  ToDo
//
//  Created by Jacob Bartlett on 31/05/2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct ToDoDropDelegate: DropDelegate {
    
    let item: ToDo
    @Binding var items: [ToDo]
    @Binding var draggedItem: ToDo?
    var onDrop: () -> Void
    
    func performDrop(info: DropInfo) -> Bool {
        onDrop()
        return true
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggedItem = self.draggedItem else { return }
        
        if draggedItem != item {
            guard let fromIndex = items.firstIndex(of: draggedItem),
                  let toIndex = items.firstIndex(of: item) else { return }
            withAnimation {
                items.move(fromOffsets: IndexSet(integer: fromIndex),
                           toOffset: (toIndex > fromIndex) ? (toIndex + 1) : toIndex)
            }
        }
    }
}
