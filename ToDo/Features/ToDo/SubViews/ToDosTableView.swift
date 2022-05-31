//
//  ToDosTableView.swift
//  ToDo
//
//  Created by Jacob Bartlett on 30/05/2022.
//

import SwiftUI

struct ToDosTableView: View {
    
    @EnvironmentObject private var viewModel: ToDosViewModel
    
    var body: some View {
        NewToDoView()
        ScrollView {
            toDosTable
            filterButtons
            reorderInstructions
                .padding(.top, Constants.Spacing.high)
            Spacer()
        }
        .cornerRadius(Constants.Cell.cornerRadius)
    }
    
    private var toDosTable: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.filteredTodos) {
                ToDoCellView(todo: $0)
                    .dragAndDrop(todo: $0)
                Divider()
                    .offset(y: -1)
            }
            clearItemsCell
        }
        .cornerRadius(Constants.Cell.cornerRadius)
    }
    
    private var clearItemsCell: some View {
        HStack {
            numberOfItemsLeftText
            Spacer()
            clearCompletedButton
        }
        .cellStyle()
    }
    
    private var numberOfItemsLeftText: some View {
        Text("\(viewModel.incompleteItemsCount) item\(viewModel.incompleteItemsCount == 1 ? "" : "s") left")
            .font(.regular)
            .foregroundColor(.secondaryText)
    }
    
    private var clearCompletedButton: some View {
        Button(action: {
            withAnimation {
                viewModel.clearCompleteToDos()
            }
        }, label: {
            Text("Clear Completed")
                .font(.regular)
                .foregroundColor(.secondaryText)
        })
        .buttonPadding()
    }
    
    private var filterButtons: some View {
        HStack(spacing: Constants.Spacing.high) {
            ForEach(Filter.allCases, id: \.text) { filter in
                Button(action: {
                    withAnimation {
                        viewModel.setFilter(to: filter)
                    }
                }, label: {
                    Text(filter.text)
                        .font(.bold)
                        .foregroundColor(viewModel.filter == filter ? .primaryAction : .secondaryText)
                })
                .buttonPadding()
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .cellStyle()
        .cornerRadius(Constants.Cell.cornerRadius)
    }
    
    private var reorderInstructions: some View {
        Text(String.ToDo.Table.dragAndDropToReorderList)
            .font(.regular)
            .foregroundColor(.secondaryText)
    }
}

struct ToDosTableView_Previews: PreviewProvider {
    static var previews: some View {
        ToDosTableView()
    }
}
