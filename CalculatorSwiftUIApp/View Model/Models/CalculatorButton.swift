//
//  CalculatorButton.swift
//  CalculatorSwiftUIApp
//
//  Created by Kevin on 30/06/2025.
//

import SwiftUI

// MARK: - Button Model
enum CalculatorButton: String {
    case one = "1", two = "2", three = "3"
    case four = "4", five = "5", six = "6"
    case seven = "7", eight = "8", nine = "9"
    case zero = "0", decimal = ".", equals = "="
    case add = "+", subtract = "−", multiply = "×", divide = "÷"
    case clear = "AC", negative = "±", percent = "%"
    
    var backgroundColor: Color {
        switch self {
        case .clear, .negative, .percent:
            return .gray
        case .add, .subtract, .multiply, .divide:
            return .orange
        case .equals:
            return .blue
        default:
            return .gray.opacity(0.3)
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .clear, .negative, .percent:
            return .black
        default:
            return .white
        }
    }
}
