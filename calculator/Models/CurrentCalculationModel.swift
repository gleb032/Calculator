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
}

enum Operation {
  case add, subtract, multiply, divide
}
