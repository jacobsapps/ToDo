//
//  ToDosViewModel.swift
//  ToDo
//
//  Created by Jacob Bartlett on 30/05/2022.
//

import Combine
import SwiftUI

final class ToDosViewModel: ObservableObject {
    
    private var todos: [ToDo] = [] {
        didSet {
            updateFilteredTodos()
        }
    }
    @Published var filteredTodos: [ToDo] = []
    @Published var presentError: Bool = false
    @Published var draggedItem: ToDo?
    
    @Published private(set) var filter: Filter = .all {
        didSet {
            updateFilteredTodos()
        }
    }
    @Published private(set) var colorScheme: ColorScheme = .light
    @Published private(set) var displayedError: ToDoError? {
        didSet {
            if displayedError != nil {
                presentError = true
            }
        }
    }
    
    private let dataService: ToDoDataService
    private var subscriptions = Set<AnyCancellable>()
    
    var incompleteItemsCount: Int {
        todos.filter { !$0.isComplete }.count
    }
    
    init(dataService: ToDoDataService = ToDoSimpleDataService()) {
        self.dataService = dataService
        dataService.toDosPublisher.sink(receiveValue: { [weak self] in
            guard let self = self else { return }
            self.todos = $0
        }).store(in: &subscriptions)
        updateFilteredTodos()
    }
    
    private func updateFilteredTodos() {
        filteredTodos = todos.filtered(with: filter)
    }
    
    func toggleColorScheme() {
        colorScheme.toggle()
    }
    
    func setFilter(to filter: Filter) {
        self.filter = filter
    }
    
    func toggleCompletion(of todo: ToDo) {
        do {
            try dataService.toggleCompletion(of: todo)
        } catch {
            displayedError = error as? ToDoError
        }
    }
    
    func createToDo(title: String) {
        do {
            try dataService.createToDo(title: title)
        } catch {
            displayedError = error as? ToDoError
        }
    }
    
    func delete(todo: ToDo) {
        do {
            try dataService.delete(todo: todo)
        } catch {
            displayedError = error as? ToDoError
        }
    }
    
    func clearCompleteToDos() {
        dataService.clearCompleteToDos()
    }
    
    func updateSortOrder() {
        let filtered = filteredTodos
        let others = todos.filter { !filtered.contains($0) }
        let sortedTodos = filtered + others
        dataService.updateSortOrder(todos: sortedTodos)
    }
}
