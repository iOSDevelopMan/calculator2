//
//  CurrencyConvertor.swift
//  Calculator
//
//  Created by Alexey Kachura on 18.09.23.
//

import Foundation

final class CurrencyConvertor {
    // MARK: - Types
    public enum Currency: String, Decodable {
        case usd = "USD"
        case btc = "BTC"
    }
    
    private struct CurrencyInfo: Decodable {
        let rates: [String: Double]
    }
    
    public enum CurrencyConvertorError: Error {
        case failed
    }
    
    // MARK: - Properties
    private let link = "http://api.exchangeratesapi.io/v1/latest?access_key=58ddce00104c8437ff02a7eccd1df5bc&symbols=USD,BTC&format=1"
    
    // MARK: - Lifecycle
    static let shared = CurrencyConvertor()
    private init() {}
    
    // MARK: - Main
    public func convert(value: Double, from fromCurrency: Currency, to toCurrency: Currency, completion: @escaping (Result<Double, Error>) -> Void) {
        guard let url = URL(string: link) else {
            completion(.failure(CurrencyConvertorError.failed))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data else {
                    completion(.failure(CurrencyConvertorError.failed))
                    return
                }
                
                let currencyInfo: CurrencyInfo
                
                do {
                    currencyInfo = try JSONDecoder().decode(CurrencyInfo.self, from: data)
                } catch {
                    print(error)
                    completion(.failure(CurrencyConvertorError.failed))
                    return
                }
                
                guard let usdRate = currencyInfo.rates[Currency.usd.rawValue],
                      let btcRate = currencyInfo.rates[Currency.btc.rawValue] else {
                    completion(.failure(CurrencyConvertorError.failed))
                    return
                }
                
                let rate = btcRate / usdRate
                let btc = value * rate
                completion(.success(btc))
            }
        }.resume()
    }
}
