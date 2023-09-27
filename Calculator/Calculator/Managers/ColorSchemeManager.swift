//
//  ColorSchemeManager.swift
//  Calculator
//
//  Created by Alexey Kachura on 27.09.23.
//

import Foundation
import Combine

protocol ColorSchemeManagerProtocol {
    var colorScheme: CurrentValueSubject<ColorSchemeProtocol, Never> { get }
    init(_ colorScheme: ColorSchemeProtocol)
}

class ColorSchemeManager: ColorSchemeManagerProtocol {
    var colorScheme: CurrentValueSubject<ColorSchemeProtocol, Never>
    
    required init(_ colorScheme: ColorSchemeProtocol) {
        self.colorScheme = .init(colorScheme)
    }
}
