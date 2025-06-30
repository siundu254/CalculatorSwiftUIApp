//
//  CalculatorButtonView.swift
//  CalculatorSwiftUIApp
//
//  Created by Kevin on 30/06/2025.
//

import SwiftUI

struct CalculatorButtonView: View {
    let button: CalculatorButton
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(button.rawValue)
                .font(.system(size: 32))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(button.backgroundColor)
                .foregroundColor(button.foregroundColor)
                .clipShape(Circle())
                .shadow(radius: 2)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
