//
//  LoginViewController.swift
//  Login
//
//  Created by Geonhee on 2023/03/13.
//

import PXDesignSystem
import RIBs
import RxSwift
import SharedModels
import UIKit

protocol LoginPresentableListener: AnyObject {
  func didTapLoginButton(with user: User)
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {

  weak var listener: LoginPresentableListener?

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    return stackView
  }()

  private let userNameTextField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.placeholder = "Type your name..."
    return textField
  }()

  private lazy var logInButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 15
    button.layer.cornerCurve = .continuous
    button.clipsToBounds = true
    button.setBackgroundColor(.systemBlue, for: .normal)
    button.setTitle("Sign in", for: .normal)
    button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    return button
  }()

  init() {
    super.init(nibName: nil, bundle: nil)
    attribute()
    setupViews()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }

  private func attribute() {
    self.view.backgroundColor = .systemBackground
  }

  private func setupViews() {
    self.view.addSubview(stackView)

    stackView.addArrangedSubview(userNameTextField)
    stackView.addArrangedSubview(logInButton)

    NSLayoutConstraint.activate([
      logInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
      logInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
      logInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      logInButton.heightAnchor.constraint(equalToConstant: 50),
    ])
  }

  @objc
  private func didTapLoginButton() {
    guard let userName = userNameTextField.text else { return }

    let user = User(name: userName)
    listener?.didTapLoginButton(with: user)
  }
}
