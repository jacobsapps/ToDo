//
//  ColorScheme+Extensions.swift
//  ToDo
//
//  Created by Jacob Bartlett on 30/05/2022.
//

import SwiftUI

extension ColorScheme {
    
    mutating func toggle() {
        if self == .light {
            self = .dark
        } else {
            self = .light
        }
    }
}
