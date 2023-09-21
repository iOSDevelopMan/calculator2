//
//  AppDelegate.swift
//  Calculator
//
//  Created by Alexey Kachura on 21.09.23.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseService.shared.configure()
        return true
    }
}
