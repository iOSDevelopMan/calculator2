//
//  ReachabilityService.swift
//  Calculator
//
//  Created by Alexey Kachura on 20.09.23.
//

import Foundation
import Network
import Combine

protocol ReachabilityServiceProtocol {
    var isOnline: CurrentValueSubject<Bool, Never> { get }
}

class ReachabilityService: ReachabilityServiceProtocol {
    static let shared = ReachabilityService()
    
    var isOnline: CurrentValueSubject<Bool, Never> = .init(true)
    
    private let monitor = NWPathMonitor()
    
    private init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        isOnline.send(monitor.currentPath.status == .satisfied)
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isOnline.send(path.status == .satisfied)
            }
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
