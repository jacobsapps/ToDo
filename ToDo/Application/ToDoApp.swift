//
//  ToDoApp.swift
//  ToDo
//
//  Created by Jacob Bartlett on 28/05/2022.
//

import SwiftUI

@main
struct ToDoApp: App {
    
    var viewModel = ToDosViewModel()
    
    var body: some Scene {
        WindowGroup {
            ToDosView()
                .environmentObject(viewModel)
        }
    }
}
