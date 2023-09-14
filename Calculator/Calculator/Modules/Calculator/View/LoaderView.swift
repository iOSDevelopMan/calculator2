//
//  LoaderView.swift
//  Calculator
//
//  Created by Alexey Kachura on 21.09.23.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.7)
            ProgressView()
                .scaleEffect(3)
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
