//
//  Calculation.swift
//  CalculatorSwiftUIApp
//
//  Created by Kevin on 30/06/2025.
//

import Foundation

// MARK: - Models
struct Calculation: Identifiable {
    let id = UUID()
    let expression: String
    let result: String
}

enum CalculatorOperation {
    case add, subtract, multiply, divide
}
