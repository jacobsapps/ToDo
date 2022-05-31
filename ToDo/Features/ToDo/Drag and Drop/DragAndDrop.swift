//
//  DragAndDrop.swift
//  ToDo
//
//  Created by Jacob Bartlett on 31/05/2022.
//

import SwiftUI
import UniformTypeIdentifiers

extension View {
    
    /// Enable drag and drop functionality to re-order ToDo objects in a table
    /// **Warning:** This will only work in a SwiftUI view environment where a ToDosViewModel is accessible
    ///
    func dragAndDrop(todo: ToDo) -> some View {
        modifier(DragAndDrop(todo: todo))
    }
}

struct DragAndDrop: ViewModifier {
    
    @EnvironmentObject private var viewModel: ToDosViewModel
    var todo: ToDo
    
    func body(content: Content) -> some View {
        content
            .onDrag {
                viewModel.draggedItem = todo
                return NSItemProvider(item: nil, typeIdentifier: todo.id)
            }
            .onDrop(of: [UTType.text], delegate: ToDoDropDelegate(item: todo,
                                                                  items: $viewModel.filteredTodos,
                                                                  draggedItem: $viewModel.draggedItem,
                                                                  onDrop: { viewModel.updateSortOrder() }))
    }
}
