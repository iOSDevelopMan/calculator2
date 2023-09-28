//
//  CurrencyService.swift
//  Calculator
//
//  Created by Alexey Kachura on 28.09.23.
//

import Foundation

public enum CurrencyServiceError: Error {
    case badUrl
    case failed
    case missedCurrancies
}

public struct CurrencyServiceResponse: Decodable {
    let rates: [String: Double]
}

public class CurrencyService {
    // MARK: - Properties
    private let link = "http://api.exchangeratesapi.io/v1/latest?access_key=58ddce00104c8437ff02a7eccd1df5bc&symbols=USD,BTC&format=1"
    
    public func getCurrencies(completion: @escaping (Result<CurrencyServiceResponse, Error>) -> Void) {
        guard let url = URL(string: link) else {
            completion(.failure(CurrencyServiceError.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else {
                completion(.failure(CurrencyServiceError.failed))
                return
            }
            
            do {
                let currencyInfo = try JSONDecoder().decode(CurrencyServiceResponse.self, from: data)
                completion(.success(currencyInfo))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
}
