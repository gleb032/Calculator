//
//  Operations+Colors.swift
//  calculator
//
//  Created by Gleb Fandeev on 26.08.2022.
//

import Foundation

enum ButtonColor {
  case darkGrey, orange, red
}

let operations = [",","=","+","-","×","AC","%","/"]

let operationColor : [String : ButtonColor] = [
  "," : .darkGrey,
  "=" : .orange,
  "+" : .orange,
  "-" : .orange,
  "×" : .orange,
  "AC" : .red,
  "%" : .darkGrey,
  "/" : .orange
]
