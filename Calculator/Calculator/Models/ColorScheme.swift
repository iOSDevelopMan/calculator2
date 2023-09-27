//
//  ColorScheme.swift
//  Calculator
//
//  Created by Alexey Kachura on 18.09.23.
//

import Foundation
import SwiftUI

protocol ColorSchemeProtocol {
    var background: Color { get }
    var title1: Color { get }
    var title2: Color { get }
    var actionBackground1: Color { get }
    var actionBackground2: Color { get }
    var actionBackground3: Color { get }
    var cryptoCurrencyBackground: Color { get }
}

struct FirstColorScheme: ColorSchemeProtocol {
    var background: Color = .black
    var title1: Color = .white
    var title2: Color = .black
    var actionBackground1: Color = .init(uiColor: .darkGray)
    var actionBackground2: Color = .gray
    var actionBackground3: Color = .orange
    var cryptoCurrencyBackground: Color = .blue
}

struct SecondColorScheme: ColorSchemeProtocol {
    var background: Color = .white
    var title1: Color = .black
    var title2: Color = .white
    var actionBackground1: Color = .blue
    var actionBackground2: Color = .gray
    var actionBackground3: Color = .pink
    var cryptoCurrencyBackground: Color = .green
}
