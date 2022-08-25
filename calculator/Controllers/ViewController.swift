//
//  ViewController.swift
//  calculator
//
//  Created by Gleb Fandeev on 24.08.2022.
//

// TODO: refactor and structurize code
// TODO: add top line of bottoms (think about which buttons to add and their layout) 
/// this is a draft version

import UIKit

class ViewController: UIViewController {

  var numberButton = [CalculatorButton]()

  var currentCalculation = Calculation()

  let commaButton = CalculatorButton(
    title: ",",
    color: .darkGrey
  )
  let equalButton = CalculatorButton(
    title: "=",
    color: .orange
  )
  let plusButton = CalculatorButton(
    title: "+",
    color: .orange
  )
  let minusButton = CalculatorButton(
    title: "-",
    color: .orange
  )
  let multiptyButton = CalculatorButton(
    title: "x",
    color: .orange
  )
  let deleteButton = CalculatorButton(
    title: "AC",
    color: .red
  )
  let procentButton = CalculatorButton(
    title: "%",
    color: .darkGrey
  )
  let divideButton = CalculatorButton(
    title: "/",
    color: .orange
  )
  var firstButtonsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  var secondButtonsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  var thirdButtonsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    setUpButtonsLayout()
  }

  private func setUpButtonsLayout() {
    numberButton.append(CalculatorButton(
      title: "0",
      color: .darkGrey
    ))
    for number in 1...9 {
      numberButton.append(CalculatorButton(
        title: String(number),
        color: .darkGrey
      ))
    }

    let viewHeight = view.frame.height
    let viewWidth = view.frame.width
    let buttonHeight = viewHeight / 10
    let buttonWidth = (viewWidth - 5*10) / 4
    let dist = 10.0

    view.addSubview(numberButton[0])
    numberButton[0].bottomAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.bottomAnchor,
      constant: -dist
    ).isActive = true
    numberButton[0].leadingAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.leadingAnchor,
      constant: dist
    ).isActive = true
    numberButton[0].heightAnchor.constraint(
      equalToConstant: buttonHeight
    ).isActive = true
    numberButton[0].widthAnchor.constraint(
      equalToConstant: buttonWidth * 2 + dist
    ).isActive = true
    numberButton[0].layer.cornerRadius = buttonHeight / 2

    view.addSubview(commaButton)
    commaButton.bottomAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.bottomAnchor,
      constant: -dist
    ).isActive = true
    commaButton.leadingAnchor.constraint(
      equalTo: numberButton[0].trailingAnchor,
      constant: dist
    ).isActive = true
    commaButton.heightAnchor.constraint(
      equalToConstant: buttonHeight
    ).isActive = true
    commaButton.widthAnchor.constraint(
      equalToConstant: buttonWidth
    ).isActive = true
    commaButton.layer.cornerRadius = buttonHeight / 2

    view.addSubview(equalButton)
    equalButton.bottomAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.bottomAnchor,
      constant: -dist
    ).isActive = true
    equalButton.leadingAnchor.constraint(
      equalTo: commaButton.trailingAnchor,
      constant: dist
    ).isActive = true
    equalButton.heightAnchor.constraint(
      equalToConstant: buttonHeight
    ).isActive = true
    equalButton.widthAnchor.constraint(
      equalToConstant: buttonWidth
    ).isActive = true
    equalButton.layer.cornerRadius = buttonHeight / 2

    firstButtonsView = setUpButtonsLine(
      [numberButton[1], numberButton[2], numberButton[3], plusButton],
      viewHeight: viewHeight,
      viewWidth: viewWidth,
      buttonHeight: buttonHeight,
      buttonWidth: buttonWidth,
      dist: dist
    )

    view.addSubview(firstButtonsView)
    firstButtonsView.leadingAnchor.constraint(
      equalTo: view.leadingAnchor
    ).isActive = true
    firstButtonsView.trailingAnchor.constraint(
      equalTo: view.trailingAnchor
    ).isActive = true
    firstButtonsView.bottomAnchor.constraint(
      equalTo:  numberButton[0].topAnchor,
      constant: -dist
    ).isActive = true
    firstButtonsView.heightAnchor.constraint(
      equalToConstant: buttonHeight
    ).isActive = true

    secondButtonsView = setUpButtonsLine(
      [numberButton[4], numberButton[5], numberButton[6], minusButton],
      viewHeight: viewHeight,
      viewWidth: viewWidth,
      buttonHeight: buttonHeight,
      buttonWidth: buttonWidth,
      dist: dist
    )

    view.addSubview(secondButtonsView)
    secondButtonsView.leadingAnchor.constraint(
      equalTo: view.leadingAnchor
    ).isActive = true
    secondButtonsView.trailingAnchor.constraint(
      equalTo: view.trailingAnchor
    ).isActive = true
    secondButtonsView.bottomAnchor.constraint(
      equalTo:  firstButtonsView.topAnchor,
      constant: -dist
    ).isActive = true
    secondButtonsView.heightAnchor.constraint(
      equalToConstant: buttonHeight
    ).isActive = true

    thirdButtonsView = setUpButtonsLine(
      [numberButton[7], numberButton[8], numberButton[9], multiptyButton],
      viewHeight: viewHeight,
      viewWidth: viewWidth,
      buttonHeight: buttonHeight,
      buttonWidth: buttonWidth,
      dist: dist
    )

    view.addSubview(thirdButtonsView)
    thirdButtonsView.leadingAnchor.constraint(
      equalTo: view.leadingAnchor
    ).isActive = true
    thirdButtonsView.trailingAnchor.constraint(
      equalTo: view.trailingAnchor
    ).isActive = true
    thirdButtonsView.bottomAnchor.constraint(
      equalTo:  secondButtonsView.topAnchor,
      constant: -dist
    ).isActive = true
    thirdButtonsView.heightAnchor.constraint(
      equalToConstant: buttonHeight
    ).isActive = true

    view.addSubview(deleteButton)
    deleteButton.bottomAnchor.constraint(
      equalTo: thirdButtonsView.safeAreaLayoutGuide.topAnchor,
      constant: -dist
    ).isActive = true
    deleteButton.leadingAnchor.constraint(
      equalTo: thirdButtonsView.safeAreaLayoutGuide.leadingAnchor,
      constant: dist
    ).isActive = true
    deleteButton.heightAnchor.constraint(
      equalToConstant: buttonHeight
    ).isActive = true
    deleteButton.widthAnchor.constraint(
      equalToConstant: buttonWidth * 2 + dist
    ).isActive = true
    deleteButton.layer.cornerRadius = buttonHeight / 2

    view.addSubview(procentButton)
    procentButton.bottomAnchor.constraint(
      equalTo: thirdButtonsView.safeAreaLayoutGuide.topAnchor,
      constant: -dist
    ).isActive = true
    procentButton.leadingAnchor.constraint(
      equalTo: deleteButton.trailingAnchor,
      constant: dist
    ).isActive = true
    procentButton.heightAnchor.constraint(
      equalToConstant: buttonHeight
    ).isActive = true
    procentButton.widthAnchor.constraint(
      equalToConstant: buttonWidth
    ).isActive = true
    procentButton.layer.cornerRadius = buttonHeight / 2

    view.addSubview(divideButton)
    divideButton.bottomAnchor.constraint(
      equalTo: thirdButtonsView.safeAreaLayoutGuide.topAnchor,
      constant: -dist
    ).isActive = true
    divideButton.leadingAnchor.constraint(
      equalTo: procentButton.trailingAnchor,
      constant: dist
    ).isActive = true
    divideButton.heightAnchor.constraint(
      equalToConstant: buttonHeight
    ).isActive = true
    divideButton.widthAnchor.constraint(
      equalToConstant: buttonWidth
    ).isActive = true
    divideButton.layer.cornerRadius = buttonHeight / 2

  }

  // MARK: 4 buttons inline !!!
  private func setUpButtonsLine(
    _ buttons: [UIButton],
    viewHeight: CGFloat,
    viewWidth: CGFloat,
    buttonHeight: CGFloat,
    buttonWidth: CGFloat,
    dist: CGFloat
  ) -> UIView {
    guard buttons.count == 4 else {
      fatalError("4 buttons!")
    }

    let view: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()

    for index in 0..<4 {
      view.addSubview(buttons[index])
      buttons[index].bottomAnchor.constraint(
        equalTo: view.bottomAnchor
      ).isActive = true
      buttons[index].leadingAnchor.constraint(
        equalTo: index==0 ? view.leadingAnchor : buttons[index-1].trailingAnchor,
        constant: dist
      ).isActive = true
      buttons[index].heightAnchor.constraint(
        equalToConstant: buttonHeight
      ).isActive = true
      buttons[index].widthAnchor.constraint(
        equalToConstant: buttonWidth
      ).isActive = true
      buttons[index].layer.cornerRadius = buttonHeight / 2
    }

    return view
  }

}


