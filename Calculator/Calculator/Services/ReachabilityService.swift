//
//  ReachabilityService.swift
//  Calculator
//
//  Created by Alexey Kachura on 20.09.23.
//

import Foundation
import Network

protocol ReachabilityServiceProtocol {
    var isOnlinePublisher: Published<Bool>.Publisher { get }
}

class ReachabilityService: ReachabilityServiceProtocol {
    static let shared = ReachabilityService()
    private init() {
        startMonitoring()
    }
    
    private let monitor = NWPathMonitor()
    
    @Published var isOnline: Bool = true
    var isOnlinePublisher: Published<Bool>.Publisher { $isOnline }
    
    func startMonitoring() {
        isOnline = monitor.currentPath.status == .satisfied
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isOnline = path.status == .satisfied
            }
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
