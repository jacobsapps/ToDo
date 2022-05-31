//
//  ToDoView.swift
//  ToDo
//
//  Created by Jacob Bartlett on 30/05/2022.
//

import SwiftUI

struct ToDosView: View {
    
    @EnvironmentObject private var viewModel: ToDosViewModel
    
    var body: some View {
        VStack(spacing: Constants.Spacing.high) {
            header
                .padding(.bottom, Constants.Spacing.high)
            ToDosTableView()
        }
        .padding(.horizontal, Constants.Spacing.high)
        .background(backgroundView)
        .preferredColorScheme(viewModel.colorScheme)
        .alert(viewModel.displayedError?.title ?? String.ToDo.Error.error, isPresented: $viewModel.presentError) {
            Button(String.ToDo.Error.ok, role: .cancel) {}
        }
    }
    
    private var header: some View {
        HStack {
            Text(String.ToDo.header)
                .font(.large)
                .kerning(6)
                .foregroundColor(.white)
            Spacer()
            lightDarkModeToggle
        }
    }
    
    private var lightDarkModeToggle: some View {
        Button(action: {
            withAnimation {
                viewModel.toggleColorScheme()
            }
        }, label: {
            Image.fit(viewModel.colorScheme == .light ? Image.Icon.moon : Image.Icon.sun)
                .frame(width: 22, height: 22)
                .buttonPadding()
        })
    }
    
    var backgroundView: some View {
        VStack(spacing: 0) {
            Image.fill(viewModel.colorScheme == .light ? Image.Picture.lightBanner : Image.Picture.darkBanner)
                .frame(height: 200)
            Color.primaryBackground
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ToDosView_Previews: PreviewProvider {
    static var previews: some View {
        ToDosView()
    }
}
