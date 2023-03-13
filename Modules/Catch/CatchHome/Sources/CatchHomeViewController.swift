//
//  CatchHomeViewController.swift
//  CatchHome
//
//  Created by Geonhee on 2023/03/13.
//

import PXDesignSystem
import RIBs
import RxSwift
import SharedModels
import UIKit

protocol CatchHomePresentableListener: AnyObject {
  func didTapLoginButton()
  func didTapStartButton()
}

final class CatchHomeViewController:
  UIViewController,
  CatchHomePresentable,
  CatchHomeViewControllable {

  private lazy var logInButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 15
    button.layer.cornerCurve = .continuous
    button.clipsToBounds = true
    button.setBackgroundColor(.systemBlue, for: .normal)
    button.setTitle("Sign in", for: .normal)
    button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    return button
  }()

  private lazy var startButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    button.layer.cornerRadius = 15
    button.layer.cornerCurve = .continuous
    button.clipsToBounds = true
    button.setBackgroundColor(.systemBlue, for: .normal)
    button.setTitle("Go to Catch", for: .normal)
    return button
  }()

  weak var listener: CatchHomePresentableListener?

  init() {
    super.init(nibName: nil, bundle: nil)
    attribute()
    setupViews()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }

  func layoutLoggedIn() {
    logInButton.isHidden = true
    startButton.isHidden = false
  }

  func layoutLoggedOut() {
    logInButton.isHidden = false
    startButton.isHidden = true
  }

  private func attribute() {
    title = "Catch Pokémons"
    self.view.backgroundColor = .systemGray6
    tabBarItem = UITabBarItem(
      title: "Catch",
      image: UIImage(systemName: "bag"),
      selectedImage: UIImage(systemName: "bag.fill")
    )
  }

  private func setupViews() {
    self.view.addSubview(logInButton)
    self.view.addSubview(startButton)

    NSLayoutConstraint.activate([
      logInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
      logInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
      logInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      logInButton.heightAnchor.constraint(equalToConstant: 50),

      startButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
      startButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
      startButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      startButton.heightAnchor.constraint(equalToConstant: 50),
    ])
  }

  @objc
  private func didTapLoginButton() {
    listener?.didTapLoginButton()
  }

  @objc
  private func didTapStartButton() {
    listener?.didTapStartButton()
  }
}
