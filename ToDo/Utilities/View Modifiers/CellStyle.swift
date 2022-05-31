//
//  CellStyle.swift
//  ToDo
//
//  Created by Jacob Bartlett on 30/05/2022.
//

import SwiftUI

extension View {
    
    /// Apply a background color and shape consistent with the ToDo style guide
    ///
    func cellStyle(height: CGFloat = Constants.Cell.mediumCellHeight) -> some View {
        modifier(CellStyle(height: height))
    }
}

struct CellStyle: ViewModifier {
    
    private let height: CGFloat
    
    init(height: CGFloat) {
        self.height = height
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, Constants.Spacing.high)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(Color.secondaryBackground)
    }
}
