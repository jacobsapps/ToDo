//
//  ToDoCellView.swift
//  ToDo
//
//  Created by Jacob Bartlett on 30/05/2022.
//

import SwiftUI

struct ToDoCellView: View {
    
    @EnvironmentObject private var viewModel: ToDosViewModel
    
    var todo: ToDo
    
    private var toDoIndex: Array<ToDo>.Index? {
        viewModel.filteredTodos[indexOf: todo]
    }
    
    private var isComplete: Bool {
        guard let index = toDoIndex else { return false }
        return viewModel.filteredTodos[index].isComplete
    }
    
    var body: some View {
        HStack(spacing: Constants.Spacing.med) {
            checkmark
            title
            Spacer()
            cross
        }
        .padding(.horizontal, -Constants.Spacing.low)
        .cellStyle(height: Constants.Cell.largeCellHeight)
    }
    
    private var checkmark: some View {
        Button(action: {
            withAnimation {
                viewModel.toggleCompletion(of: todo)
            }
        }, label: {
            CheckmarkView(isComplete: isComplete)
        })
        .buttonPadding()
    }
    
    private var title: some View {
        Text(todo.title)
            .font(.regular)
            .foregroundColor(isComplete ? .secondaryText : .primaryText)
            .strikethrough(isComplete, color: .secondaryText)
            .lineLimit(1)
            .minimumScaleFactor(0.2)
            .offset(y: 1)
    }
    
    private var cross: some View {
        Button(action: {
            withAnimation {
                viewModel.delete(todo: todo)
            }
        }, label: {
            Image.fit(Image.Icon.cross)
                .frame(width: 14, height: 14)
        })
        .buttonPadding()
    }
}

struct ToDoCellView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoCellView(todo: ToDo(title: "Complete online JavaScript course", isComplete: true))
    }
}
