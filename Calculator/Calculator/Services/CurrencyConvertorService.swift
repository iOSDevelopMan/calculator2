//
//  CurrencyConvertorService.swift
//  Calculator
//
//  Created by Alexey Kachura on 18.09.23.
//

import Foundation

protocol CurrencyConvertorServiceProtocol {
    func convertToBtc(value: Double, completion: @escaping (Result<Double, Error>) -> Void)
}

class CurrencyConvertorService: CurrencyConvertorServiceProtocol {
    static let shared = CurrencyConvertorService()
    private let currencyConvertor = CurrencyConvertor.shared
    private init() {}
    
    func convertToBtc(value: Double, completion: @escaping (Result<Double, Error>) -> Void) {
        currencyConvertor.convert(value: value, from: .usd, to: .btc, completion: completion)
    }
}
