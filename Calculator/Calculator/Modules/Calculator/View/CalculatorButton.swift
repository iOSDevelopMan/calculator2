//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Alexey Kachura on 21.09.23.
//

import SwiftUI

struct CalculatorButton: View {
    let viewModel: CalculatorButtonViewModel
    let size: CGFloat
    let onTap: () -> Void
    
    var body: some View {
        let fontSize = size / 2.2
        if viewModel.isEnabled {
            Button {
                onTap()
            } label: {
                Text(viewModel.title)
                    .frame(width: size, height: size)
                    .font(.system(size: fontSize))
                    .foregroundColor(viewModel.foregroundColor)
            }
            .buttonStyle(.borderedProminent)
            .tint(viewModel.backgroundColor)
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: size / 2))
        } else {
            Circle()
                .frame(width: size, height: size)
                .foregroundColor(.clear)
        }
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(
            viewModel: .init(
                title: "@",
                foregroundColor: .pink,
                backgroundColor: .gray,
                actionType: .operand,
                isEnabled: true),
            size: 80,
            onTap: { print("On Tap") }
        )
    }
}
