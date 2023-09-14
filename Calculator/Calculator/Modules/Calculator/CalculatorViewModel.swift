//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Alexey Kachura on 15.09.23.
//

import SwiftUI
import Combine

class CalculatorViewModel: ObservableObject {
    // MARK: - Properties
    private let currencyConvertorService: CurrencyConvertorServiceProtocol
    private let reachabilityService: ReachabilityServiceProtocol
    
    private var colors = ColorScheme.second.colors
    
    lazy var buttons: [[CalculatorButtonViewModel]] = [
        [
            .init(title: "AC", foregroundColor: colors.title2, backgroundColor: colors.actionBackground2, actionType: .operation, isEnabled: true),
            .init(title: "cos", foregroundColor: colors.title2, backgroundColor: colors.actionBackground2, actionType: .operation, isEnabled: true),
            .init(title: "sin", foregroundColor: colors.title2, backgroundColor: colors.actionBackground2, actionType: .operation, isEnabled: true),
            .init(title: "/", foregroundColor: colors.title1, backgroundColor: colors.actionBackground3, actionType: .operation, isEnabled: true)
        ],
        [
            .init(title: "7", foregroundColor: colors.title1, backgroundColor: colors.actionBackground1, actionType: .operand, isEnabled: true),
            .init(title: "8", foregroundColor: colors.title1, backgroundColor: colors.actionBackground1, actionType: .operand, isEnabled: true),
            .init(title: "9", foregroundColor: colors.title1, backgroundColor: colors.actionBackground1, actionType: .operand, isEnabled: true),
            .init(title: "*", foregroundColor: colors.title1, backgroundColor: colors.actionBackground3, actionType: .operation, isEnabled: true)
        ],
        [
            .init(title: "4", foregroundColor: colors.title1, backgroundColor: colors.actionBackground1, actionType: .operand, isEnabled: true),
            .init(title: "5", foregroundColor: colors.title1, backgroundColor: colors.actionBackground1, actionType: .operand, isEnabled: true),
            .init(title: "6", foregroundColor: colors.title1, backgroundColor: colors.actionBackground1, actionType: .operand, isEnabled: true),
            .init(title: "-", foregroundColor: colors.title1, backgroundColor: colors.actionBackground3, actionType: .operation, isEnabled: true)
        ],
        [
            .init(title: "1", foregroundColor: colors.title1, backgroundColor: colors.actionBackground1, actionType: .operand, isEnabled: true),
            .init(title: "2", foregroundColor: colors.title1, backgroundColor: colors.actionBackground1, actionType: .operand, isEnabled: true),
            .init(title: "3", foregroundColor: colors.title1, backgroundColor: colors.actionBackground1, actionType: .operand, isEnabled: true),
            .init(title: "+", foregroundColor: colors.title1, backgroundColor: colors.actionBackground3, actionType: .operation, isEnabled: true)
        ],
        [
            .init(title: "₿", foregroundColor: colors.title1, backgroundColor: colors.cryptoCurrencyBackground, actionType: .exchange, isEnabled: true),
            .init(title: "0", foregroundColor: colors.title1, backgroundColor: colors.actionBackground1, actionType: .operand, isEnabled: true),
            .init(title: "", foregroundColor: colors.title1, backgroundColor: colors.actionBackground1, actionType: .operand, isEnabled: false),
            .init(title: "=", foregroundColor: colors.title1, backgroundColor: colors.actionBackground3, actionType: .operation, isEnabled: true)
        ]
    ]
    
    var backgroundColor: Color { colors.background }
    var resultColor: Color { colors.title1 }
    var loaderColor: Color { colors.cryptoCurrencyBackground }
    
    @Published private var calculatorLogic = CalculatorLogic()
    @Published var isOnline = true
    @Published var isLoading = false
    @Published var isErrorAlertVisible = false
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 6
        return formatter
    }()
    
    var formattedResult: String { numberFormatter.string(from: calculatorLogic.result as NSNumber) ?? "0" }
    
    private var inTheMiddle = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    init(currencyConvertorService: CurrencyConvertorServiceProtocol = CurrencyConvertorService.shared,
         reachabilityService: ReachabilityServiceProtocol = ReachabilityService.shared) {
        self.currencyConvertorService = currencyConvertorService
        self.reachabilityService = reachabilityService
        
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupReachabilityService()
    }
    
    private func setupReachabilityService() {
        reachabilityService.isOnlinePublisher
            .sink { [weak self ] in self?.isOnline = $0 }
            .store(in: &cancellables)
    }
    
    // MARK: - Main
    func calculatorSizes(screenSize: CGSize) -> CalculatorSizes {
        .init(
            screenSize: screenSize,
            rowsCount: buttons.count,
            columnsCount: buttons.first?.count ?? 4
        )
    }
    
    func handleButtonPressed(buttonViewModel: CalculatorButtonViewModel) {
        switch buttonViewModel.actionType {
        case .operand:
            let inputValue = Double(buttonViewModel.title) ?? 0
            let value: Double
            if inTheMiddle {
                value = calculatorLogic.result * 10 + inputValue
            } else {
                value = inputValue
                inTheMiddle = true
            }
            
            calculatorLogic.setOperand(value)
        case .operation:
            calculatorLogic.performOperation(buttonViewModel.title)
            inTheMiddle = false
        case .exchange:
            isLoading = true

            currencyConvertorService.convertToBtc(value: calculatorLogic.result) { [weak self] result in
                guard let self else { return }

                isLoading = false

                switch result {
                case .success(let value):
                    inTheMiddle = false
                    calculatorLogic.setOperand(value)
                case .failure(let error):
                    print(error)
                    isErrorAlertVisible = true
                }
            }
        }
    }
}
