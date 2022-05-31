//
//  CheckmarkView.swift
//  ToDo
//
//  Created by Jacob Bartlett on 30/05/2022.
//

import SwiftUI

struct CheckmarkView: View {
    
    var isComplete: Bool
    
    var body: some View {
        if isComplete {
            checkmark
        } else {
            circle
        }
    }
    
    private var checkmark: some View {
        Image.fit(Image.Icon.check)
            .frame(width: 11, height: 11)
            .offset(y: 1)
            .frame(width: 22, height: 22)
            .background(
                gradient
            )
            .cornerRadius(11)
    }
    
    private var gradient: some View {
        LinearGradient(gradient: Gradient(colors: [.gradientStart, .gradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var circle: some View {
        ZStack {
            Circle()
                .frame(width: 22, height: 22)
                .foregroundColor(.secondaryText)
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(.secondaryBackground)
        }
    }
}

struct CheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CheckmarkView(isComplete: true)
            CheckmarkView(isComplete: false)
        }
    }
}
