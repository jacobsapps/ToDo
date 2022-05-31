//
//  ToDoSimpleDataService.swift
//  ToDo
//
//  Created by Jacob Bartlett on 31/05/2022.
//

import Foundation

/// Implementation of the data layer simply storing un-encoded objects on the stack.
/// The publisher adds significant complexity here, and is overkill for a simple app, but enables the other implementations to use the same interface
/// 
final class ToDoSimpleDataService: ToDoDataService {
    
    private static var sampleToDos: [ToDo] = [
        ToDo(title: "Complete online JavaScript course", isComplete: true),
        ToDo(title: "Jog around the park 3x"),
        ToDo(title: "10 minutes meditation"),
        ToDo(title: "Read for 1 hour"),
        ToDo(title: "Pick up groceries"),
        ToDo(title: "Complete Todo App on Frontend")
    ]
        
    @Published private(set) var todos: [ToDo]
    
    var toDosPublisher: Published<[ToDo]>.Publisher { $todos }
    
    init(todos: [ToDo] = sampleToDos) {
        self.todos = todos
    }
    
    func toggleCompletion(of todo: ToDo) throws {
        guard let index = todos[indexOf: todo] else {
            throw ToDoError.todoNotFound
        }
        todos[index].isComplete.toggle()
    }
    
    func delete(todo: ToDo) throws {
        guard let index = todos[indexOf: todo] else {
            throw ToDoError.todoNotFound
        }
        todos.remove(at: index)
    }

    func createToDo(title: String) throws {
        guard !title.isEmpty else {
            throw ToDoError.invalidToDo
        }
        let todo = ToDo(title: title)
        todos.append(todo)
    }
    
    func clearCompleteToDos() {
        todos = todos.filter { !$0.isComplete }
    }
    
    func updateSortOrder(todos: [ToDo]) {
        self.todos = todos
    }
}
