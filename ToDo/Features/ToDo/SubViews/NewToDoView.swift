//
//  NewToDoView.swift
//  ToDo
//
//  Created by Jacob Bartlett on 30/05/2022.
//

import SwiftUI

struct NewToDoView: View {
    
    @EnvironmentObject private var viewModel: ToDosViewModel
    @State private var newToDoTitle: String = ""
    
    var body: some View {
        HStack(spacing: Constants.Spacing.med) {
            checkmark
            textField
            if !newToDoTitle.isEmpty {
                Spacer()
                cross
            }
        }
        .cellStyle()
        .cornerRadius(Constants.Cell.cornerRadius)
    }
    
    private var checkmark: some View {
        CheckmarkView(isComplete: false)
    }
    
    private var textField: some View {
        TextField("New todo", text: $newToDoTitle, prompt: promptText)
            .onSubmit {
                withAnimation {
                    viewModel.createToDo(title: newToDoTitle)
                    newToDoTitle = ""
                }
            }
            .font(.regular)
            .foregroundColor(.primaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(y: 1)
    }
    
    private var promptText: Text {
        Text(String.ToDo.Table.createANewToDo)
            .font(.regular)
            .foregroundColor(.secondaryText)
    }
    
    private var cross: some View {
        Button(action: {
            withAnimation {
                newToDoTitle = ""
            }
        }, label: {
            Image.fit(Image.Icon.cross)
                .frame(width: 14, height: 14)
        })
        .buttonPadding()
    }
}

struct NewToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NewToDoView()
    }
}
