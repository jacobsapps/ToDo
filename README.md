# ``ToDo``

ToDo app built with SwiftUI, MVVM, and Combine

## Features

- View optimal layout for the app depending on device screen size - the app works perfectly across iPhone 13 Mini, iPhone 13, iPhone 13 Pro Max, and 11" and 12.9" iPad Pro models.
- Add new todos to the list, mark todos as complete, and delete todos from the list.
- Filter by all/active/complete todos and clear all completed todos.
- Support light and dark mode (toggled by a button on the UI).
- Hold down an item on the list to drag and drop to reorder items on the list [WARNING - since the screen is implemented with a ScrollView you must hold down for a moment before dragging].  

## Architecture

The app is built using MVVM and SwiftUI, with Combine to enable a reactive data layer.

### View layer 
- The ToDosView and the associated subviews.
- The viewModel was added as an environment object to enable all subviews to acceess it.
- SwiftUI enabled a very easy implementation of the MVVM Observer model by using an @ObservableObject view model, where views can reacting to state changes of the @Published properties of the view model.  

### View Model
- The core business logic was located in the ToDosViewModel, including data processing and retrieval.  
- User input was passed to the view model which passed it down to the data layer.
- The data layer was passed into the initializer through dependency injection, to enable any other implementation or a mock service to be easily passed in during tests. 

### Data Layer 
- A DataService abstraction was used to represent the data layer in the app.
- The abstraction means that any implementation of synchronous operations on an underlying data layer can be kept in sync with the client.  
- Combine was used with a `toDosPublisher` to enable the view model to stay fully in sync with the underlying data 
- A very basic implementation that did not use persistence was used here, but it would be very easy to adopt the ToDoDataService protocol with any synchronous implementation using UserDefaults, Core Data, or even data on a server (but async )  
- In a more complex app, with simple changes to the interface, asynchronous or generic models can be used as well 

## Testing 

A pragmatic approach was taken for testing, where care was taken to ensure coverage across all business logic in the data layer and view models. Views themselves were not tested since they contained no business logic. 

Therefore, in this simple application only two test files were needed: 
- **100%** unit test coverage in ToDosViewModel
- **100%** unit test coverage in ToDoSimpleDataService

A ToDoDataServiceTestSpec test specification was created for the ToDoDataService protocol. This is to help ensure that any concrete implementation of ToDoDataService meets the exact same specifications regardless of the underlying implementation.  
