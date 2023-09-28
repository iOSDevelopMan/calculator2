//
//  CurrencyConvertorService.swift
//  Calculator
//
//  Created by Alexey Kachura on 18.09.23.
//

import Foundation

public enum CurrencyConvertorError: Error {
    case missedCurrancies
}

public protocol CurrencyConvertorServiceProtocol {
    func convertToBtc(value: Double, completion: @escaping (Result<Double, Error>) -> Void)
}

public class CurrencyConvertorService: CurrencyConvertorServiceProtocol {
    // MARK: - Properties
    private let currencyService = CurrencyService()
    
    // MARK: - CurrencyConvertorServiceProtocol
    public func convertToBtc(value: Double, completion: @escaping (Result<Double, Error>) -> Void) {
        currencyService.getCurrencies { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    guard let usdRate = response.rates["USD"],
                          let btcRate = response.rates["BTC"] else {
                        completion(.failure(CurrencyConvertorError.missedCurrancies))
                        return
                    }

                    let rate = btcRate / usdRate
                    let btc = value * rate
                    completion(.success(btc))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
