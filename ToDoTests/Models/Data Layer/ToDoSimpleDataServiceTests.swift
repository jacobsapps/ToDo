//
//  ToDoSimpleDataServiceTests.swift
//  ToDoTests
//
//  Created by Jacob Bartlett on 31/05/2022.
//

@testable import ToDo
import XCTest

final class ToDoSimpleDataServiceTests: XCTestCase, ToDoDataServiceTestSpec {
        
    fileprivate static let sampleToDos: [ToDo] = [
        ToDo(title: "Complete online JavaScript course", isComplete: true),
        ToDo(title: "Jog around the park 3x")
    ]
    
    fileprivate static let fakeToDo: ToDo = ToDo(title: "Fake ToDo", isComplete: false)
    
    fileprivate func createSut(with todos: [ToDo] = sampleToDos) -> ToDoSimpleDataService {
        ToDoSimpleDataService(todos: todos)
    }
}

extension ToDoSimpleDataServiceTests {
    
    func test_toggleCompletionOfToDo_successfullyTogglesCompletion() {
        let sut = createSut()
        XCTAssertEqual(sut.todos.filter { $0.isComplete }.count, 1)
        
        do {
            try sut.toggleCompletion(of: Self.sampleToDos[1])
            XCTAssertEqual(sut.todos.filter { $0.isComplete }.count, 2)
            
            try sut.toggleCompletion(of: Self.sampleToDos[0])
            try sut.toggleCompletion(of: Self.sampleToDos[1])
            XCTAssertEqual(sut.todos.filter { $0.isComplete }.count, 0)
            
        } catch {
            XCTFail("Error is not expected")
        }
    }
    
    func test_toggleCompletionOfToDo_failsToFindToDoItem() {
        let sut = createSut()
        
        XCTAssertThrowsError(try sut.toggleCompletion(of: Self.fakeToDo)) { error in
            XCTAssertEqual(error as? ToDoError, ToDoError.todoNotFound)
        }
    }
}

extension ToDoSimpleDataServiceTests {
    
    func test_createToDo_successfullyCreatesNewToDoItem() {
        let sut = createSut()
        do {
            XCTAssertEqual(sut.todos.count, 2)
            try sut.createToDo(title: "New ToDo 1")
            XCTAssertEqual(sut.todos.count, 3)
            try sut.createToDo(title: "New ToDo 2")
            XCTAssertEqual(sut.todos.count, 4)
            try sut.createToDo(title: "New ToDo 3")
            XCTAssertEqual(sut.todos.count, 5)
            
        } catch {
            XCTFail("Error is not expected")
        }
    }
    
    func test_createToDo_failsDueToInvalidToDo() {
        let sut = createSut()
        XCTAssertThrowsError(try sut.createToDo(title: "")) { error in
            XCTAssertEqual(error as? ToDoError, ToDoError.invalidToDo)
        }
    }
}


extension ToDoSimpleDataServiceTests {
    func test_deleteToDo_successfullyDeletesToDo() {
        let sut = createSut()
        XCTAssertEqual(sut.todos.count, 2)
        do {
            try sut.delete(todo: Self.sampleToDos[1])
            XCTAssertEqual(sut.todos.count, 1)
            
            try sut.delete(todo: Self.sampleToDos[0])
            XCTAssertEqual(sut.todos.count, 0)
            
        } catch {
            XCTFail("Error is not expected")
        }
    }
    
    func test_deleteToDo_failsToFindToDoItem() {
        let sut = createSut()
        XCTAssertThrowsError(try sut.delete(todo: Self.fakeToDo)) { error in
            XCTAssertEqual(error as? ToDoError, ToDoError.todoNotFound)
        }
    }
}

extension ToDoSimpleDataServiceTests {
    
    func test_clearCompleteItems_successfullyClearsCompleteItems() {
        let sut = createSut()
        XCTAssertEqual(sut.todos.count, 2)
        sut.clearCompleteToDos()
        XCTAssertEqual(sut.todos.count, 1)
    }
}

extension ToDoSimpleDataServiceTests {
    
    func test_updateSortOrder_successfullyUpdatesSortOrder() {
        let sut = createSut()
        XCTAssertEqual(sut.todos, Self.sampleToDos)
        sut.updateSortOrder(todos: Self.sampleToDos.reversed())
        XCTAssertEqual(sut.todos, Self.sampleToDos.reversed())
    }
}
