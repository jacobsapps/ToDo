//
//  Font+Extensions.swift
//  ToDo
//
//  Created by Jacob Bartlett on 29/05/2022.
//

import SwiftUI

extension Font {
    
    static var regular: Font = {
        Font.custom("JosefinSans-Regular", size: 14)
    }()
    
    static var bold: Font = {
        Font.custom("JosefinSans-Bold", size: 18)
    }()
    
    static var large: Font = {
        Font.custom("JosefinSans-Bold", size: 26)
    }()
}

struct Font_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack(spacing: Constants.Spacing.high) {
            Text("This is some header font")
                .font(.large)
            Text("This is some bold font")
                .font(.bold)
            Text("This is some regular font")
                .font(.regular)
        }
    }
}
