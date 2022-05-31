//
//  ToDoDataService.swift
//  ToDo
//
//  Created by Jacob Bartlett on 31/05/2022.
//

import Combine

/// Façade over any implementation of synchronous operations on an underlying data layer kept in sync with the client.
/// This has a publisher which a client can subscribe to in order to observe the latest changes made to the underlying data.
/// This ensures a clean MVVM architecture can be set up.
///
/// Options for implementation include but are not limited to:
/// - No persistence, storing the non-encoded data in RAM
/// - User Defaults, holding encoded objects as data
/// - Core Data, storing data as NSManagedObject
///
/// A version of this protocol with async methods could be created to represent data stored on a server and kept in sync with the client.
/// In a more complex application, this data layer would also operate using generics rather than a concrete ToDo type.
///
protocol ToDoDataService: AnyObject {
    var toDosPublisher: Published<[ToDo]>.Publisher { get }
    func toggleCompletion(of todo: ToDo) throws
    func createToDo(title: String) throws
    func delete(todo: ToDo) throws
    func clearCompleteToDos()
    func updateSortOrder(todos: [ToDo])
}
