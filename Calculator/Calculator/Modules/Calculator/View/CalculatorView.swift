//
//  CalculatorView.swift
//  Calculator
//
//  Created by Alexey Kachura on 14.09.23.
//

import SwiftUI
import Analytics

struct CalculatorView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let calculatorSizes = viewModel.calculatorSizes(screenSize: geometry.size)
            
            ZStack {
                viewModel.backgroundColor
                    .ignoresSafeArea()

                VStack(spacing: calculatorSizes.spacing) {
                    StatusView(isOnline: viewModel.isOnline)

                    Spacer()

                    ResultView(title: viewModel.formattedResult)
                        .font(.system(size: calculatorSizes.resultFontSize))
                        .foregroundColor(viewModel.resultColor)

                    buttons(spacing: calculatorSizes.spacing, size: calculatorSizes.itemSize)
                }
                .padding(.horizontal, calculatorSizes.horizontalPadding)
            }
            .alert(isPresented: $viewModel.isErrorAlertVisible) {
                Alert(
                    title: Text("Oops. Something went wrong!"),
                    message: Text("Try again later"),
                    dismissButton: .default(Text("Got it"))
                )
            }
            
            if viewModel.isLoading {
                LoaderView()
                    .tint(viewModel.loaderColor)
            }
        }
    }
    
    func buttons(spacing: CGFloat, size: CGFloat) -> some View {
        ForEach(viewModel.buttons.indices, id: \.self) { index in
            HStack(spacing: spacing) {
                ForEach(viewModel.buttons[index]) { buttonViewModel in
                    CalculatorButton(
                        viewModel: buttonViewModel,
                        size: size
                    ) {
                        viewModel.handleButtonPressed(buttonViewModel: buttonViewModel)
                    }
                    .disabled(buttonViewModel.actionType == .exchange && !viewModel.isOnline)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(viewModel: CalculatorViewModel(analyticsService: AnalyticsCenter(services: [])))
    }
}
