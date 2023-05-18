//
//  ViewController.swift
//  MyCalculator
//
//  Created by Ваня Лаптий on 01.05.2023.
//

import UIKit

enum CurrentNumber {
    case firstNumber
    case secondNumber
}

class CalculatorController: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let additionalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let displayLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 85)
        return label
    }()
    
    var isPortrait = true
    
    var portrait: [NSLayoutConstraint]?
    var landscape: [NSLayoutConstraint]?
    var additionalStackViewLandscape: [NSLayoutConstraint]?
    
    
    let calculatorButtonCellsPortrait: [[CalculatorButton]] = [
        [.allClear, .negative, .percentage, .divide],
        [.number (7), .number (8), .number (9), .multiply],
        [.number (4), .number (5), .number (6), .subtract],
        [.number (1), .number (2), .number (3), .add],
        [.number (0), .decimal, .equals]
    ]
    
    let calculatorButtonCellsLandscape: [[CalculatorButton]] = [
        [.allClear, .negative, .percentage, .divide],
        [.number (7), .number (8), .number (9), .multiply],
        [.number (4), .number (5), .number (6), .subtract],
        [.number (1), .number (2), .number (3), .add],
        [.number (0), .decimal, .equals]
    ]
    
    let additionalButtonCellsLandscape: [[CalculatorButton]] = [
        [.square],
        [.squareRoot],
        [.sin],
        [.cos],
        [.tan]
    ]
    
    private(set) var currentNumber: CurrentNumber = .firstNumber
    
    private(set) var firstNumber: String? = nil {
        didSet {
            if ((firstNumber?.contains(".")) != nil) {
                firstNumberIsDecimal = true
            } else {
                firstNumberIsDecimal = false
            }
            self.displayLabel.text = self.firstNumber?.description ?? "0"
        }
    }
    
    private(set) var secondNumber: String? = nil {
        didSet {
            if ((secondNumber?.contains(".")) != nil) {
                secondNumberIsDecimal = true
            } else {
                secondNumberIsDecimal = false
            }
            self.displayLabel.text = self.secondNumber?.description ?? "0"
        }
    }
    
    private var equalIsPressed: Bool = false
    
    private var currentOperation: CalculatorOperation? = nil
    
    private(set) var firstNumberIsDecimal: Bool = false
    private(set) var secondNumberIsDecimal: Bool = false
    
    private(set) var prevNumber: String? = nil
    private(set) var prevOperation: CalculatorOperation? = nil
    
    var eitherNumberIsDecimal: Bool {
        return firstNumberIsDecimal || secondNumberIsDecimal
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        isPortrait = UIDevice.current.orientation.isPortrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupStackView()
        setupDisplayLabel()
        setupAdditionalStackView()
        print(isPortrait)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if isPortrait {
            NSLayoutConstraint.activate(portrait!)
            NSLayoutConstraint.deactivate(landscape!)
            NSLayoutConstraint.deactivate(additionalStackViewLandscape!)
            additionalStackView.isHidden = true
        } else {
            NSLayoutConstraint.activate(landscape!)
            NSLayoutConstraint.activate(additionalStackViewLandscape!)
            NSLayoutConstraint.deactivate(portrait!)
            additionalStackView.isHidden = false
        }
        
        for rowStackView in stackView.arrangedSubviews {
           if let rowStackView = rowStackView as? UIStackView {
               for button in rowStackView.arrangedSubviews {
                   if let button = button as? CalculatorButtonView {
                       button.layoutIfNeeded()
                       button.setupUI(buttonHeight: button.frame.height)
                   }
               }
               for subView in rowStackView.arrangedSubviews {
                   if let subView = subView as? UIStackView {
                       for subButton in subView.arrangedSubviews {
                           if let subButton = subButton as? CalculatorButtonView {
                               subButton.layoutIfNeeded()
                               subButton.setupUI(buttonHeight: subButton.frame.height)
                           }
                       }
                   }
               }
           }
        }
        for rowStackView in additionalStackView.arrangedSubviews {
            if let rowStackView = rowStackView as? UIStackView {
                for button in rowStackView.arrangedSubviews {
                    if let button = button as? CalculatorButtonView {
                        button.layoutIfNeeded()
                        button.setupUI(buttonHeight: button.frame.height)
                    }
                }
            }
        }
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        portrait = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -60),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ]
        
        landscape = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -60),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -60),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ]
        
        fillStackView()
    }
    
    
    private func setupAdditionalStackView() {
        isPortrait = true
        view.addSubview(additionalStackView)
        additionalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        additionalStackViewLandscape = [
            additionalStackView.topAnchor.constraint(equalTo: stackView.topAnchor),
            additionalStackView.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),
            additionalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            additionalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 150)
        ]
        
        fillAdditionadStackView()
    }
    
    private func fillAdditionadStackView() {
        let rowStackView = UIStackView()
        rowStackView.axis = .vertical
        rowStackView.spacing = 10
        rowStackView.alignment = .fill
        rowStackView.distribution = .fillEqually
        for row in additionalButtonCellsLandscape {
            for buttonCell in row {
                let button = CalculatorButtonView(calculatorButton: buttonCell)
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
            }
        }
        additionalStackView.addArrangedSubview(rowStackView)
    }
    
    private func fillStackView() {
        
        var buttonCells: [[CalculatorButton]] {
            if isPortrait {
                return calculatorButtonCellsPortrait
            } else {
                return calculatorButtonCellsLandscape
            }
        }
        for row in buttonCells {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.spacing = 10
            rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually
            
            let rowSubStackView = UIStackView()
            rowSubStackView.axis = .horizontal
            rowSubStackView.spacing = 10
            rowSubStackView.alignment = .fill
            rowSubStackView.distribution = .fillEqually
             
            for buttonCell in row {
                let button = CalculatorButtonView(calculatorButton: buttonCell)
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                if buttonCell.title == "." {
                    rowSubStackView.addArrangedSubview(button)
                } else if buttonCell.title == "="{
                    rowSubStackView.addArrangedSubview(button)
                    rowStackView.addArrangedSubview(rowSubStackView)
                } else {
                    rowStackView.addArrangedSubview(button)
                }
            }
            stackView.addArrangedSubview(rowStackView)
        }
    }
    
    private func setupDisplayLabel() {
        view.addSubview(displayLabel)
        displayLabel.text = "0"
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        displayLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -10).isActive = true
        displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }
}

extension CalculatorController {
    
    @objc private func buttonTapped(_ sender: CalculatorButtonView) {
        
        let button = sender.calculatorButton
        switch button {
        case .allClear:
            didSelectAllClear()
        case .equals:
            didSelectEqualsButton()
        case .add:
            didSelectOperation(with: .add)
        case .divide:
            didSelectOperation(with: .divide)
        case .multiply:
            didSelectOperation(with: .multiply)
        case .subtract:
            didSelectOperation(with: .subtract)
        case .number(_):
            didSelectNumberButton(with: button.title)
        case .decimal:
            didSelectDecimalButton()
        case .negative:
            didSelectNegative()
        case .percentage:
            didSelectPercentage()
        case .squareRoot:
            didSelectSquareRoot()
        case .square:
            didSelectSquare()
        case .sin:
            didSelectSin()
        case .cos:
            didSelectCos()
        case .tan:
            didSelectTan()
        }
    }
}

extension CalculatorController {
    
    private func didSelectAllClear() {
        displayLabel.text = "0"
        firstNumber = nil
        secondNumber = nil
        currentNumber = .firstNumber
        currentOperation = nil
        firstNumberIsDecimal = false
        secondNumberIsDecimal = false
        prevNumber = nil
        prevOperation = nil
    }
    
    private func didSelectNumberButton(with buttonTitle: String) {
        if equalIsPressed  && currentNumber == .firstNumber {
            didSelectAllClear()
            equalIsPressed = false
        }
        
        displayLabel.text?.append(buttonTitle)
        while displayLabel.text?.first == "0"
                && displayLabel.text?.count ?? 1 > 1 {
            displayLabel.text?.removeFirst()
        }
        
        if currentNumber == .firstNumber {
            if var firstNumber = firstNumber {
                firstNumber.append(buttonTitle)
                self.firstNumber = firstNumber
                prevNumber = firstNumber
            } else {
               firstNumber = buttonTitle
                prevNumber = buttonTitle
            }
        } else {
            if var secondNumber = self.secondNumber {
                secondNumber.append(buttonTitle)
                self.secondNumber = secondNumber
                prevNumber = secondNumber
            } else {
                self.secondNumber = buttonTitle
                prevNumber = buttonTitle
            }
        }
    }
    
    private func didSelectNegative() {
        if currentNumber == .firstNumber {
            var number = firstNumber ?? "0"
            if number.first != "-" {
                number.insert("-", at: number.startIndex)
            } else if number.first == "-" {
                number.removeFirst()
            }
            firstNumber = number
        } else if currentNumber == .secondNumber {
            var number = secondNumber ?? "0"
            if number.first != "-" {
                number.insert("-", at: number.startIndex)
            } else if number.first == "-" {
                number.removeFirst()
            }
            secondNumber = number
        }
    }
    
    private func didSelectDecimalButton() {
        if currentNumber == .firstNumber {
            var number = firstNumber ?? "0"
            number.append(".")
            if number.first == "0" {
                number.removeFirst()
            }
            if number.first == "." {
                number.insert("0", at: number.startIndex)
            }
            firstNumber = number
        } else if currentNumber == .secondNumber {
            var number = secondNumber ?? "0"
            number.append(".")
            if number.first == "0" {
                number.removeFirst()
            }
            if number.first == "." {
                number.insert("0", at: number.startIndex)
            }
            secondNumber = number
        }
    }
    
    private func didSelectPercentage() {
        if currentNumber == .firstNumber,
           var number = firstNumber?.toDouble {
            
            number /= 100
            
            if number.isInteger {
                firstNumber = number.toInt?.description
            } else {
                firstNumber = number.description
            }
        } else if currentNumber == .secondNumber,
                  var number = secondNumber?.toDouble {
            
            number /= 100
            
            if number.isInteger {
                secondNumber = number.toInt?.description
            } else {
                secondNumber = number.description
            }
        }
    }
    
    private func didSelectEqualsButton() {
        if let operation = currentOperation,
           let firstNumber = firstNumber?.toDouble,
           let secondNumber = secondNumber?.toDouble {
            
            let result = getOperationResult(operation, firstNumber, secondNumber)
            displayLabel.text = eitherNumberIsDecimal ? result.description : result.toInt?.description
            
            self.secondNumber = nil
            prevOperation = operation
            currentOperation = nil
            self.firstNumber = eitherNumberIsDecimal ? result.description : result.toInt?.description
            currentNumber = .firstNumber
            
        } else if let prevOperation = prevOperation,
                  let firstNumber = firstNumber?.toDouble,
                  let prevNumber = prevNumber?.toDouble {
            let result = getOperationResult(prevOperation, firstNumber, prevNumber)
            let resultString = eitherNumberIsDecimal ? result.description : result.toInt?.description
            self.firstNumber = resultString
        }
        equalIsPressed = true
    }
    
    private func didSelectSquareRoot () {
        singleNumberOperation(operation: sqrt)
    }
    
    private func didSelectSquare() {
        singleNumberOperation(operation: myPow)
    }
    
    private func didSelectSin() {
        singleNumberOperation(operation: sin)
    }
    
    private func didSelectCos() {
        singleNumberOperation(operation: cos)
    }
    
    private func didSelectTan() {
        singleNumberOperation(operation: tan)
    }
    
    private func myPow(number: Double) -> Double {
        return number * number
    }
    
    private func singleNumberOperation(operation: ((Double) -> Double)) {
        if currentNumber == .firstNumber,
           var number = firstNumber?.toDouble {
            
            number = operation(number)
            
            number.isInteger
            ? (firstNumber = number.toInt?.description)
            : (firstNumber = number.description)
            
        } else if currentNumber == .secondNumber,
                  var number = secondNumber?.toDouble {
            
            number = operation(number)
            
            number.isInteger
            ? (secondNumber = number.toInt?.description)
            : (secondNumber = number.description)
        }
    }
    
    private func didSelectOperation(with operation: CalculatorOperation) {
        
        if currentNumber == .firstNumber {
            currentOperation = operation
            currentNumber = .secondNumber
        } else if self.currentNumber == .secondNumber {
            
            if let prevOperation = currentOperation,
               let firstNumber = firstNumber?.toDouble,
               let secondNumber = secondNumber?.toDouble {
                
                let result = getOperationResult(prevOperation, firstNumber, secondNumber)
                displayLabel.text = eitherNumberIsDecimal ? result.description : result.toInt?.description
                
                self.secondNumber = nil
                self.firstNumber = eitherNumberIsDecimal ? result.description : result.toInt?.description
                currentNumber = .secondNumber
                currentOperation = operation
            } else {
                currentOperation = operation
            }
        }
    }
    
    private func getOperationResult(_ operation: CalculatorOperation,
                                    _ firstNumber: Double?,
                                    _ secondNumber: Double?) -> Double {
        
        guard let firstNumber = firstNumber, let secondNumber = secondNumber else { return 0 }

        switch operation {
        case .divide:
            return firstNumber / secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .add:
            return firstNumber + secondNumber
        }
    }
}
