//
//  Color+Extensions.swift
//  ToDo
//
//  Created by Jacob Bartlett on 29/05/2022.
//

import SwiftUI

extension Color {
    
    /// **SemanticColor**
    /// Colors are named based on their usage rather than their color.
    /// This enables the names to work seamlessly in both light and dark mode.
    ///
    private enum SemanticColor: String {
        case primaryBackground
        case secondaryBackground
        case primaryText
        case secondaryText
        case primaryAction
        case secondaryAction
        case gradientStart
        case gradientEnd
    }
    
    static var primaryBackground: Color = {
        Color(SemanticColor.primaryBackground.rawValue)
    }()
    
    static var secondaryBackground: Color = {
        Color(SemanticColor.secondaryBackground.rawValue)
    }()
    
    static var primaryText: Color = {
        Color(SemanticColor.primaryText.rawValue)
    }()
    
    static var secondaryText: Color = {
        Color(SemanticColor.secondaryText.rawValue)
    }()
    
    static var primaryAction: Color = {
        Color(SemanticColor.primaryAction.rawValue)
    }()
    
    static var secondaryAction: Color = {
        Color(SemanticColor.secondaryAction.rawValue)
    }()
    
    static var gradientStart: Color = {
        Color(SemanticColor.gradientStart.rawValue)
    }()
    
    static var gradientEnd: Color = {
        Color(SemanticColor.gradientEnd.rawValue)
    }()
}

struct Color_Previews: PreviewProvider {
    
    static let colors: [Color] = [
        .primaryBackground,
        .secondaryBackground,
        .primaryText,
        .secondaryText,
        .primaryAction,
        .secondaryAction,
        .gradientStart,
        .gradientEnd
    ]
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack(spacing: 16) {
                ForEach(colors, id: \.self) {
                    $0
                }
            }
            .preferredColorScheme($0)
        }
    }
}
