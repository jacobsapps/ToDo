//
//  ToDoDataServiceTestSpec.swift
//  ToDoTests
//
//  Created by Jacob Bartlett on 31/05/2022.
//

@testable import ToDo
import XCTest

/// This spec ensures all implementations ToDoDataService have the same test cases
///
protocol ToDoDataServiceTestSpec: XCTestCase {
    func test_toggleCompletionOfToDo_successfullyTogglesCompletion()
    func test_toggleCompletionOfToDo_failsToFindToDoItem()
    func test_createToDo_successfullyCreatesNewToDoItem()
    func test_createToDo_failsDueToInvalidToDo()
    func test_deleteToDo_successfullyDeletesToDo()
    func test_deleteToDo_failsToFindToDoItem()
    func test_clearCompleteItems_successfullyClearsCompleteItems()
    func test_updateSortOrder_successfullyUpdatesSortOrder()
}
