//
//  ColorScheme.swift
//  Calculator
//
//  Created by Alexey Kachura on 18.09.23.
//

import Foundation
import SwiftUI

enum ColorScheme: String {
    case normal
    case second
    
    var colors: SchemeColorsProtocol.Type {
        switch self {
        case .normal: return NormalSchemeColors.self
        case .second: return SecondSchemeColors.self
        }
    }
}

protocol SchemeColorsProtocol {
    static var background: Color { get }
    static var title1: Color { get }
    static var title2: Color { get }
    static var actionBackground1: Color { get }
    static var actionBackground2: Color { get }
    static var actionBackground3: Color { get }
    static var cryptoCurrencyBackground: Color { get }
}

struct NormalSchemeColors: SchemeColorsProtocol {
    static var background: Color { .black }
    static var title1: Color { .white }
    static var title2: Color { .black }
    static var actionBackground1: Color { .init(uiColor: .darkGray) }
    static var actionBackground2: Color { .gray }
    static var actionBackground3: Color { .orange }
    static var cryptoCurrencyBackground: Color { .blue }
}

struct SecondSchemeColors: SchemeColorsProtocol {
    static var background: Color { .white }
    static var title1: Color { .black }
    static var title2: Color { .white }
    static var actionBackground1: Color { .blue }
    static var actionBackground2: Color { .gray }
    static var actionBackground3: Color { .pink }
    static var cryptoCurrencyBackground: Color { .green }
}
