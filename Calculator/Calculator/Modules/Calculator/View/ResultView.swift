//
//  ResultView.swift
//  Calculator
//
//  Created by Alexey Kachura on 21.09.23.
//

import SwiftUI

struct ResultView: View {
    let title: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .multilineTextAlignment(.trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(title: "3.14")
    }
}
