//
//  CalculatorButton.swift
//  MyCalculator
//
//  Created by Ваня Лаптий on 02.05.2023.
//

import UIKit

enum CalculatorButton {
    case allClear
    case negative
    case percentage
    case divide
    case multiply
    case subtract
    case add
    case equals
    case number(Int)
    case decimal
    case squareRoot
    case square
    case sin
    case cos
    case tan
    
    init(calcButton: CalculatorButton) {
        switch calcButton {
        case .allClear, .negative, .percentage, .divide, .multiply, .subtract, .add, .equals, .decimal, .squareRoot, .square, .sin, .cos, .tan:
            self = calcButton
        case .number(let int):
            if int.description.count == 1 {
                self = calcButton
            } else {
                fatalError("CalculatorButton.number Int was not 1 diggit during init")
            }
        }
    }
}

extension CalculatorButton {
    var title: String {
        switch self {
        case .allClear:
            return "AC"
        case .negative:
            return "+/-"
        case .percentage:
            return "%"
        case .divide:
            return "÷"
        case .multiply:
            return "×"
        case .subtract:
            return "-"
        case .add:
            return "+"
        case .equals:
            return "="
        case .number(let int):
            return int.description
        case .decimal:
            return "."
        case .squareRoot:
            return "√"
        case .square:
            return "x²"
        case .sin:
            return "sin"
        case .cos:
            return "cos"
        case .tan:
            return "tan"
        }
    }
    
    var color: UIColor {
        switch self {
        case .allClear, .negative, .percentage:
            return .lightGray
        case .divide, .multiply, .subtract, .add, .equals:
            return .systemOrange
        case .number, .decimal:
            return .darkGray
        case  .squareRoot, .square, .sin, .cos, .tan:
            return .systemGray
        }
    }
    
    var selectedColor: UIColor? {
        switch self {
        case .allClear, .negative, .percentage, .equals, .number, .decimal, .squareRoot, .square, .sin, .cos, .tan:
            return nil
        case .divide, .multiply, .subtract, .add:
            return .white
        }
    }
}
