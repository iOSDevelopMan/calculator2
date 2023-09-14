//
//  CalculatorSizes.swift
//  Calculator
//
//  Created by Alexey Kachura on 20.09.23.
//

import Foundation

struct CalculatorSizes {
    let spacing: CGFloat = 8
    let resultFontSize: CGFloat
    let resultTextHeight: CGFloat
    let itemSize: CGFloat
    let horizontalPadding: CGFloat
    
    init(screenSize: CGSize, rowsCount: Int, columnsCount: Int) {
        resultFontSize = screenSize.height / 7
        resultTextHeight = resultFontSize * 2
        
        let itemWidth = (screenSize.width - CGFloat(columnsCount + 1) * spacing) / CGFloat(columnsCount)
        let itemHeight = (screenSize.height - resultTextHeight - CGFloat(rowsCount + 1) * spacing) / CGFloat(rowsCount)
        itemSize = min(itemWidth, itemHeight)
        horizontalPadding = (screenSize.width - CGFloat(columnsCount) * itemSize - CGFloat(columnsCount - 1) * spacing) / 2
    }
}
