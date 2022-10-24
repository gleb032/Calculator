//
//  CurrentCalculationModel.swift
//  calculator
//
//  Created by Gleb Fandeev on 24.08.2022.
//

import Foundation


struct Calculation {
  var firstNumber: Double = 0
  var secondNumber: Double?
  var operation: Operation?

  mutating func doOperation(button: Button) {
    switch button {
    case .number(let num):
      if let x = secondNumber {
        secondNumber = x * 10 + num
      } else {
        if let _ = operation {
          secondNumber = num
          break
        }
        firstNumber = firstNumber * 10 + num
      }
    case .operation(let operation):
      self.operation = operation
    case .equal:
      firstNumber = getResult(operation: operation)
    }
  }
  private mutating func getResult(operation: Operation?) -> Double {
    guard let operation = operation else {
      return firstNumber
    }
    if operation == .procent {
      return firstNumber * 0.01
    }
    guard let secondNumber = secondNumber else {
      return firstNumber
    }
    switch operation {
    case .add:
      firstNumber+=secondNumber
    case .subtract:
      firstNumber-=secondNumber
    case .multiply:
      firstNumber *= secondNumber
    case .divide:
      firstNumber /= secondNumber
    case .procent:
      fatalError("Something went wrong")
    }
    newCalculation()
    return firstNumber
  }

  mutating func newCalculation() {
    secondNumber = nil
    operation = nil
  }

}

enum Operation {
  case add, subtract, multiply, divide, procent
}

// Operation logic here ?

enum Button {
  case number(Double)
  case operation(Operation)
  case equal
}
