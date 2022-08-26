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
    case .red:
      self.backgroundColor = .red
    }
    self.setTitle(title, for: .normal)
    self.titleLabel?.adjustsFontSizeToFitWidth = true
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
}
