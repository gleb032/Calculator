//
//  ViewController.swift
//  calculator
//
//  Created by Gleb Fandeev on 24.08.2022.
//

// MARK: this is a draft version

// TODO: refactor and structurize code
// TODO: add top line of bottoms (think about which buttons to add and their layout)
// TODO: add actions and think about calculations logic
// TODO: think about errors and its animations (ex. divide by 0)
// TODO: operations map: operation["="] -> CalculatorButton(...)
// TODO: Think about return non Optional value from above map
// Big View Controller: need to pop up some stuff
// to Custom View Class and think about sizes and so on.

import UIKit

class ViewController: UIViewController {

  var numberButton = [CalculatorButton]()

  var currentCalculation = Calculation()

  var operationButton = [String : CalculatorButton]()

  let calculationsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.isEnabled = false
    label.text = "0"
    label.textColor = .white
    label.textAlignment = .right
    label.font = .boldSystemFont(ofSize: 50)
    return label
  }()
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
    let viewHeight = view.frame.height
    let labelHeight = viewHeight / 10
    let dist = 10.0
    setUpButtonsLayout()
    setUpLabelLayout(labelHeight: labelHeight, dist: dist)
  }

  private func setUpButtonsLayout() {
    numberButton.append(CalculatorButton(
      title: "0",
      color: .darkGrey
    ))
    numberButton.last!.addTarget(self, action: #selector(tapOnNumber(_:)), for: .touchUpInside)
    for number in 1...9 {
      numberButton.append(CalculatorButton(
        title: String(number),
        color: .darkGrey
      ))
      numberButton.last!.addTarget(self, action: #selector(tapOnNumber(_:)), for: .touchUpInside)
    }

    for operation in operations {
      operationButton[operation] = CalculatorButton(
        title: operation,
        color: operationColor[operation] ?? .darkGrey
      )
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

    guard let commaButton = operationButton[","] else {
      fatalError("Comma button doesnt exist")
    }
    view.addSubview(commaButton)
    operationButton[","]?.bottomAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.bottomAnchor,
      constant: -dist
    ).isActive = true
    operationButton[","]?.leadingAnchor.constraint(
      equalTo: numberButton[0].trailingAnchor,
      constant: dist
    ).isActive = true
    operationButton[","]?.heightAnchor.constraint(
      equalToConstant: buttonHeight
    ).isActive = true
    operationButton[","]?.widthAnchor.constraint(
      equalToConstant: buttonWidth
    ).isActive = true
    operationButton[","]?.layer.cornerRadius = buttonHeight / 2

    guard let equalButton = operationButton["="] else {
      fatalError("Equal button doesnt exist")
    }
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

    guard let plusButton = operationButton["+"] else {
      fatalError("Plus button doesnt exist")
    }
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

    guard let minusButton = operationButton["-"] else {
      fatalError("Minus button doesnt exist")
    }
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

    guard let multiptyButton = operationButton["×"] else {
      fatalError("Multipty button doesnt exist")
    }
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


    // TODO: make it in view (think about fabric func)
    guard let deleteButton = operationButton["AC"] else {
      fatalError("Multipty button doesnt exist")
    }
    view.addSubview(deleteButton)
    deleteButton.bottomAnchor.constraint(
      equalTo: thirdButtonsView.topAnchor,
      constant: -dist
    ).isActive = true
    deleteButton.leadingAnchor.constraint(
      equalTo: view.leadingAnchor,
      constant: dist
    ).isActive = true
    deleteButton.heightAnchor.constraint(
      equalToConstant: buttonHeight
    ).isActive = true
    deleteButton.widthAnchor.constraint(
      equalToConstant: buttonWidth * 2 + dist
    ).isActive = true
    deleteButton.layer.cornerRadius = buttonHeight / 2

    guard let procentButton = operationButton["%"] else {
      fatalError("Procent button doesnt exist")
    }
    view.addSubview(procentButton)
    procentButton.bottomAnchor.constraint(
      equalTo: thirdButtonsView.topAnchor,
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

    guard let divideButton = operationButton["/"] else {
      fatalError("Procent button doesnt exist")
    }
    view.addSubview(divideButton)
    divideButton.bottomAnchor.constraint(
      equalTo: thirdButtonsView.topAnchor,
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

  // MARK: 4 buttons inline // Or do with at least one button with size param?
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


  // TODO: make View for last button line and constraint label with this view
  private func setUpLabelLayout(
    labelHeight: CGFloat,
    dist: CGFloat
  ) {
    guard let deleteButton = operationButton["AC"] else {
      fatalError("Delete button doesnt exist")
    }
    view.addSubview(calculationsLabel)
    calculationsLabel.leadingAnchor.constraint(
      equalTo: view.leadingAnchor,
      constant: dist*2
    ).isActive = true
    calculationsLabel.trailingAnchor.constraint(
      equalTo: view.trailingAnchor,
      constant: -dist*2
    ).isActive = true
    calculationsLabel.heightAnchor.constraint(equalToConstant: labelHeight)
      .isActive = true
    calculationsLabel.bottomAnchor.constraint(
      equalTo: deleteButton.topAnchor,
      constant: -dist
    ).isActive = true
  }

  // TODO: make this method
  @objc private func tapOnNumber(_ sender: CalculatorButton) {
    calculationsLabel.text! += sender.title(for: .normal) ?? ""
  }

  @objc private func tapOnDeleteButton(_ sender: Any) {
    currentCalculation.firstNumber = 0
    currentCalculation.newCalculation()
  }

  // TODO: Optimize it ?
  @objc private func tapOnOperationButton(_ sender: CalculatorButton) {
    let button: Button
    switch sender.titleLabel?.text {
    case "=":
      button = .equal
      break
    case "+":
      button = .operation(.add)
      break
    case "-":
      button = .operation(.subtract)
      break
    case "/":
      button = .operation(.divide)
      break
    case "×":
      button = .operation(.multiply)
      break
    case "%":
      button = .operation(.procent)
      break
    default:
      fatalError("Something went wrong")
    }
    currentCalculation.doOperation(button: button)
    currentCalculation.newCalculation()
  }

  // TODO: make logic for reloading UI after some operations
  private func reloadUIWithCalculationInfo() {
    
  }

}


