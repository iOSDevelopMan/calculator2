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
    private let analyticsService: AnalyticsServiceProtocol
    private let colorSchemeManager: ColorSchemeManagerProtocol
    private var colorScheme: ColorSchemeProtocol { colorSchemeManager.colorScheme.value }
    
    var backgroundColor: Color { colorScheme.background }
    var resultColor: Color { colorScheme.title1 }
    var loaderColor: Color { colorScheme.cryptoCurrencyBackground }
    
    @Published private(set) var buttons = [[CalculatorButtonViewModel]]()
    
    @Published private var calculatorLogic = CalculatorLogic()
    @Published private(set) var isOnline = true
    @Published private(set) var isLoading = false
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
         reachabilityService: ReachabilityServiceProtocol = ReachabilityService.shared,
         analyticsService: AnalyticsServiceProtocol = AnalyticsService(),
         colorSchemeManager: ColorSchemeManagerProtocol = ColorSchemeManager(FirstColorScheme())) {
        self.currencyConvertorService = currencyConvertorService
        self.reachabilityService = reachabilityService
        self.analyticsService = analyticsService
        self.colorSchemeManager = colorSchemeManager
        
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupColorSchemeManager()
        setupReachabilityService()
    }
    
    private func setupColorSchemeManager() {
        colorSchemeManager.colorScheme
            .sink { [weak self] _ in self?.setupButtons() }
            .store(in: &cancellables)
    }
    
    private func setupButtons() {
        buttons = [
            [
                .init(title: "AC", foregroundColor: colorScheme.title2, backgroundColor: colorScheme.actionBackground2, actionType: .operation, isEnabled: true),
                .init(title: "cos", foregroundColor: colorScheme.title2, backgroundColor: colorScheme.actionBackground2, actionType: .operation, isEnabled: true),
                .init(title: "sin", foregroundColor: colorScheme.title2, backgroundColor: colorScheme.actionBackground2, actionType: .operation, isEnabled: true),
                .init(title: "/", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground3, actionType: .operation, isEnabled: true)
            ],
            [
                .init(title: "7", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground1, actionType: .operand, isEnabled: true),
                .init(title: "8", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground1, actionType: .operand, isEnabled: true),
                .init(title: "9", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground1, actionType: .operand, isEnabled: true),
                .init(title: "*", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground3, actionType: .operation, isEnabled: true)
            ],
            [
                .init(title: "4", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground1, actionType: .operand, isEnabled: true),
                .init(title: "5", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground1, actionType: .operand, isEnabled: true),
                .init(title: "6", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground1, actionType: .operand, isEnabled: true),
                .init(title: "-", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground3, actionType: .operation, isEnabled: true)
            ],
            [
                .init(title: "1", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground1, actionType: .operand, isEnabled: true),
                .init(title: "2", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground1, actionType: .operand, isEnabled: true),
                .init(title: "3", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground1, actionType: .operand, isEnabled: true),
                .init(title: "+", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground3, actionType: .operation, isEnabled: true)
            ],
            [
                .init(title: "₿", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.cryptoCurrencyBackground, actionType: .exchange, isEnabled: true),
                .init(title: "0", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground1, actionType: .operand, isEnabled: true),
                .init(title: "", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground1, actionType: .operand, isEnabled: false),
                .init(title: "=", foregroundColor: colorScheme.title1, backgroundColor: colorScheme.actionBackground3, actionType: .operation, isEnabled: true)
            ]
        ]
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
                    analyticsService.trackEvent("Currency convertion error", params: nil)
                    print(error)
                    isErrorAlertVisible = true
                }
            }
        }
    }
}
