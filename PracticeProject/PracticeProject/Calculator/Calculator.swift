//
//  Calculator.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-09.
//

import Foundation
import UIKit

class CalculatorViewController: UIViewController {

    // Display label
    private let displayLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Number buttons
    private var numberButtons = [UIButton]()

    // Operator buttons
    private var operatorButtons = [UIButton]()

    // Other properties
    private var currentNumber: String = ""
    private var previousNumber: Double = 0
    private var currentOperator: String = ""
    private var isNewOperation: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupDisplayLabel()
        setupButtons()
        setupConstraints()
    }

    private func setupDisplayLabel() {
        view.addSubview(displayLabel)
    }

    private func setupButtons() {
        // Numbers 0-9
        for i in 0...9 {
            let button = createButton(title: "\(i)", tag: i)
            numberButtons.append(button)
            view.addSubview(button)
        }

        // Operators: +, -, *, /
        let operators = ["+", "-", "*", "/"]
        for (index, symbol) in operators.enumerated() {
            let button = createButton(title: symbol, tag: index + 10)
            operatorButtons.append(button)
            view.addSubview(button)
        }

        // Equal button
        let equalsButton = createButton(title: "=", tag: 14)
        view.addSubview(equalsButton)

        // Clear button
        let clearButton = createButton(title: "C", tag: 15)
        view.addSubview(clearButton)
    }

    private func createButton(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.tag = tag
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func setupConstraints() {
        let padding: CGFloat = 10
        let buttonHeight: CGFloat = 60
        let buttonWidth: CGFloat = (view.frame.width - padding * 5) / 4

        // Display Label
        NSLayoutConstraint.activate([
            displayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            displayLabel.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])

        // Number Buttons
        for i in 0...9 {
            let button = numberButtons[i]
            let row = (i == 0) ? 3 : (i - 1) / 3
            let column = (i == 0) ? 1 : (i - 1) % 3

            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: buttonWidth),
                button.heightAnchor.constraint(equalToConstant: buttonHeight),
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding + CGFloat(column) * (buttonWidth + padding)),
                button.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: padding + CGFloat(row) * (buttonHeight + padding))
            ])
        }

        // Operator Buttons (+, -, *, /)
        for i in 0..<operatorButtons.count {
            let button = operatorButtons[i]

            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: buttonWidth),
                button.heightAnchor.constraint(equalToConstant: buttonHeight),
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                button.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: padding + CGFloat(i) * (buttonHeight + padding))
            ])
        }

        // Equal Button (=)
        if let equalsButton = view.viewWithTag(14) as? UIButton {
            NSLayoutConstraint.activate([
                equalsButton.widthAnchor.constraint(equalToConstant: buttonWidth),
                equalsButton.heightAnchor.constraint(equalToConstant: buttonHeight),
                equalsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                equalsButton.topAnchor.constraint(equalTo: operatorButtons.last!.bottomAnchor, constant: padding)
            ])
        }

        // Clear Button (C)
        if let clearButton = view.viewWithTag(15) as? UIButton {
            NSLayoutConstraint.activate([
                clearButton.widthAnchor.constraint(equalToConstant: buttonWidth),
                clearButton.heightAnchor.constraint(equalToConstant: buttonHeight),
                clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                clearButton.topAnchor.constraint(equalTo: numberButtons.last!.bottomAnchor, constant: padding)
            ])
        }
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        if sender.tag < 10 {
            // Number button tapped
            let number = sender.tag
            if isNewOperation {
                currentNumber = "\(number)"
                isNewOperation = false
            } else {
                currentNumber += "\(number)"
            }
            displayLabel.text = currentNumber
        } else if sender.tag >= 10 && sender.tag <= 13 {
            // Operator button tapped
            if !currentNumber.isEmpty {
                previousNumber = Double(currentNumber) ?? 0
                currentOperator = operatorButtons[sender.tag - 10].title(for: .normal)!
                isNewOperation = true
            }
        } else if sender.tag == 14 {
            // Equal button tapped
            if !currentNumber.isEmpty && !currentOperator.isEmpty {
                let secondNumber = Double(currentNumber) ?? 0
                var result: Double = 0

                switch currentOperator {
                case "+":
                    result = previousNumber + secondNumber
                case "-":
                    result = previousNumber - secondNumber
                case "*":
                    result = previousNumber * secondNumber
                case "/":
                    result = previousNumber / secondNumber
                default:
                    break
                }

                displayLabel.text = String(result)
                currentNumber = String(result)
                isNewOperation = true
            }
        } else if sender.tag == 15 {
            // Clear button tapped
            currentNumber = ""
            previousNumber = 0
            currentOperator = ""
            displayLabel.text = "0"
            isNewOperation = true
        }
    }
}
