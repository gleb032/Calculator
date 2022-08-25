//
//  CalculatorButton.swift
//  calculator
//
//  Created by Gleb Fandeev on 24.08.2022.
//

import UIKit

class CalculatorButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  convenience init(title: String, color: ButtonColor) {
    self.init()
    self.translatesAutoresizingMaskIntoConstraints = false
    switch color {
    case .darkGrey:
      self.backgroundColor = .darkGray
    case .orange:
      self.backgroundColor = .orange
    }
    self.setTitle(title, for: .normal)
  }
//  init(title: String, color: ButtonColor) {
//    super.init(frame: .zero)
//    self.translatesAutoresizingMaskIntoConstraints = false
//    switch color {
//    case .darkGrey:
//      self.backgroundColor = .darkGray
//    case .orange:
//      self.backgroundColor = .orange
//    }
//    self.setTitle(title, for: .normal)
//  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
}

enum ButtonColor {
  case darkGrey, orange
}
