//
//  ToDoViewModelTests.swift
//  ToDoTests
//
//  Created by Jacob Bartlett on 30/05/2022.
//

@testable import ToDo
import XCTest

final class ToDoViewModelTests: XCTestCase {
        
    fileprivate static let sampleToDos: [ToDo] = [
        ToDo(title: "Complete online JavaScript course", isComplete: true),
        ToDo(title: "Jog around the park 3x")
    ]
    
    fileprivate static let fakeToDo: ToDo = ToDo(title: "Fake ToDo", isComplete: false)
    
    fileprivate func createSut(with todos: [ToDo] = sampleToDos) -> ToDosViewModel {
        let mockDataService: ToDoDataService = ToDoSimpleDataService(todos: todos)
        return ToDosViewModel(dataService: mockDataService)
    }
}

extension ToDoViewModelTests {
    
    func test_incompleteItemsCount_returnsNumberOfIncompleteItems() {
        let sut = createSut()
        XCTAssertEqual(sut.incompleteItemsCount, 1)
    }
}

extension ToDoViewModelTests {
    
    func test_toggleColorScheme_togglesBetweenLightAndDarkMode() {
        let sut = createSut(with: [])
        XCTAssertEqual(sut.colorScheme, .light)
        
        sut.toggleColorScheme()
        XCTAssertEqual(sut.colorScheme, .dark)
        
        sut.toggleColorScheme()
        XCTAssertEqual(sut.colorScheme, .light)
    }
}

extension ToDoViewModelTests {
    
    func test_setFilter_filtersTheCorrectToDos() {
        let sut = createSut()
        XCTAssertEqual(sut.filter, .all)
        XCTAssertEqual(sut.filteredTodos.count, 2)
        
        sut.setFilter(to: .completed)
        XCTAssertEqual(sut.filter, .completed)
        XCTAssertEqual(sut.filteredTodos.count, 1)
        
        sut.setFilter(to: .active)
        XCTAssertEqual(sut.filter, .active)
        XCTAssertEqual(sut.filteredTodos.count, 1)
        
        sut.setFilter(to: .all)
        XCTAssertEqual(sut.filter, .all)
        XCTAssertEqual(sut.filteredTodos.count, 2)
    }
}

extension ToDoViewModelTests {
    
    func test_toggleCompletionOfToDo_successfullyTogglesCompletion() {
        let sut = createSut()
        XCTAssertEqual(sut.incompleteItemsCount, 1)
        
        sut.toggleCompletion(of: Self.sampleToDos[1])
        XCTAssertEqual(sut.incompleteItemsCount, 0)
        
        sut.toggleCompletion(of: Self.sampleToDos[0])
        sut.toggleCompletion(of: Self.sampleToDos[1])
        XCTAssertEqual(sut.incompleteItemsCount, 2)
    }
    
    func test_toggleCompletionOfToDo_displaysFailureWhenFailingToFindToDoItem() {
        let sut = createSut()
        sut.toggleCompletion(of: Self.fakeToDo)
        XCTAssertEqual(sut.displayedError, ToDoError.todoNotFound)
    }
}

extension ToDoViewModelTests {
    func test_deleteToDo_successfullyDeletesToDo() {
        let sut = createSut()
        XCTAssertEqual(sut.filteredTodos.count, 2)
        
        sut.delete(todo: Self.sampleToDos[1])
        XCTAssertEqual(sut.filteredTodos.count, 1)
        
        sut.delete(todo: Self.sampleToDos[0])
        XCTAssertEqual(sut.filteredTodos.count, 0)
    }
    
    func test_deleteToDo_displaysFailureWhenFailingToFindToDoItem() {
        let sut = createSut()
        sut.delete(todo: Self.fakeToDo)
        XCTAssertEqual(sut.displayedError, ToDoError.todoNotFound)
    }
}

extension ToDoViewModelTests {
        
    func test_clearCompleteItems() {
        let sut = createSut()
        XCTAssertEqual(sut.filteredTodos.count, 2)
        sut.clearCompleteToDos()
        XCTAssertEqual(sut.filteredTodos.count, 1)
    }
}

extension ToDoViewModelTests {
        
    func test_createToDo_successfullyCreatesNewToDoItem() {
        let sut = createSut()
        XCTAssertEqual(sut.filteredTodos.count, 2)
        sut.createToDo(title: "New ToDo 1")
        XCTAssertEqual(sut.filteredTodos.count, 3)
        sut.createToDo(title: "New ToDo 2")
        XCTAssertEqual(sut.filteredTodos.count, 4)
        sut.createToDo(title: "New ToDo 3")
        XCTAssertEqual(sut.filteredTodos.count, 5)
    }
    
    func test_deleteToDo_displaysFailureWHenFailingDueToInvalidToDo() {
        let sut = createSut()
        sut.createToDo(title: "")
        XCTAssertEqual(sut.displayedError, ToDoError.invalidToDo)
    }
    
    func test_createToDo_successfullyCreatesNewToDoItemWithEmptyInitialTodos() {
        let sut = createSut(with: [])
        XCTAssertEqual(sut.filteredTodos.count, 0)
        sut.createToDo(title: "New ToDo 1")
        XCTAssertEqual(sut.filteredTodos.count, 1)
    }
}

extension ToDoViewModelTests {
    
    func test_updateSortOrder_successfullyUpdatesSortOrder() {
        let sut = createSut()
        XCTAssertEqual(sut.filteredTodos, Self.sampleToDos)
        sut.filteredTodos = Self.sampleToDos.reversed()
        XCTAssertEqual(sut.filteredTodos, Self.sampleToDos.reversed())
        sut.updateSortOrder()
        XCTAssertEqual(sut.filteredTodos, Self.sampleToDos.reversed())
    }
}
