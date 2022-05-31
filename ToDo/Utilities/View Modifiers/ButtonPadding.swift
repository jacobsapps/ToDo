//
//  ButtonPadding.swift
//  ToDo
//
//  Created by Jacob Bartlett on 31/05/2022.
//

import SwiftUI

extension View {
    
    /// Apply padding and a consistent Rectangle shape to make the tappable area of a button easy to hit
    ///
    func buttonPadding() -> some View {
        modifier(ButtonPadding())
    }
}

struct ButtonPadding: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(Constants.Spacing.low)
            .contentShape(Rectangle())
    }
}
