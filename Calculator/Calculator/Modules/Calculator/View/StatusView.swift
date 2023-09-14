//
//  StatusView.swift
//  Calculator
//
//  Created by Alexey Kachura on 21.09.23.
//

import SwiftUI

struct StatusView: View {
    let isOnline: Bool
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 10, height: 10)
            Text(isOnline ? "Online" : "Offline")
        }
        .foregroundColor(isOnline ? .green : .red)
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(isOnline: true)
    }
}
