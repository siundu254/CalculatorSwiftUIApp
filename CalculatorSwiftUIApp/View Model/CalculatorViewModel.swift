//
//  CalculatorViewModel.swift
//  CalculatorSwiftUIApp
//
//  Created by Kevin on 30/06/2025.
//

import SwiftUI
import Foundation

// MARK: - View Model
class CalculatorViewModel: ObservableObject {
    @Published var display = "0"
    @Published var currentExpression = ""
    @Published var history: [Calculation] = []
    
    private var currentNumber: Double = 0
    private var storedNumber: Double = 0
    private var currentOperation: CalculatorOperation?
    private var shouldClearDisplay = false
    
    func handleButtonPress(_ button: CalculatorButton) {
        switch button {
        case .clear:
            clear()
        case .negative:
            toggleNegative()
        case .percent:
            applyPercent()
        case .divide, .multiply, .add, .subtract:
            setOperation(button)
        case .equals:
            calculate()
        case .decimal:
            addDecimal()
        default:
            addDigit(button.rawValue)
        }
    }
    
    private func clear() {
        display = "0"
        currentExpression = ""
        currentNumber = 0
        storedNumber = 0
        currentOperation = nil
        shouldClearDisplay = false
    }
    
    private func toggleNegative() {
        if display != "0" {
            if display.hasPrefix("-") {
                display.removeFirst()
            } else {
                display = "-" + display
            }
            currentNumber = Double(display) ?? 0
        }
    }
    
    private func applyPercent() {
        if let value = Double(display) {
            currentNumber = value / 100
            display = formatNumber(currentNumber)
        }
    }
    
    private func setOperation(_ button: CalculatorButton) {
        if currentNumber != 0 {
            storedNumber = currentNumber
            currentNumber = 0
            shouldClearDisplay = true
        }
        
        currentOperation = {
            switch button {
            case .add: return .add
            case .subtract: return .subtract
            case .multiply: return .multiply
            case .divide: return .divide
            default: return nil
            }
        }()
        
        currentExpression = "\(formatNumber(storedNumber)) \(button.rawValue)"
    }
    
    private func calculate() {
        guard let operation = currentOperation else { return }
        
        let result: Double
        switch operation {
        case .add:
            result = storedNumber + currentNumber
        case .subtract:
            result = storedNumber - currentNumber
        case .multiply:
            result = storedNumber * currentNumber
        case .divide:
            result = currentNumber != 0 ? storedNumber / currentNumber : Double.infinity
        }
        
        display = formatNumber(result)
        history.append(Calculation(expression: currentExpression, result: display))
        currentExpression = ""
        currentNumber = result
        storedNumber = 0
        currentOperation = nil
        shouldClearDisplay = true
    }
    
    private func addDigit(_ digit: String) {
        if shouldClearDisplay {
            display = "0"
            shouldClearDisplay = false
        }
        
        if display == "0" {
            display = digit
        } else {
            display += digit
        }
        
        currentNumber = Double(display) ?? 0
        if currentOperation != nil {
            currentExpression = "\(formatNumber(storedNumber)) \(currentOperationSymbol()) \(display)"
        }
    }
    
    private func addDecimal() {
        if !display.contains(".") {
            display += "."
        }
    }
    
    private func currentOperationSymbol() -> String {
        switch currentOperation {
        case .add: return "+"
        case .subtract: return "−"
        case .multiply: return "×"
        case .divide: return "÷"
        case .none: return ""
        }
    }
    
    private func formatNumber(_ number: Double) -> String {
        if number.isInfinite {
            return "Error"
        }
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", number)
        }
        return String(format: "%.8f", number).trimmingCharacters(in: CharacterSet(charactersIn: "0").union(.init(charactersIn: ".")))
    }
}
