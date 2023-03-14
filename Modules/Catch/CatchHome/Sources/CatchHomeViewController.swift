//
//  CatchHomeViewController.swift
//  CatchHome
//
//  Created by Geonhee on 2023/03/13.
//

import ImageLoader
import PXDesignSystem
import PXUtilities
import RIBs
import RxSwift
import SharedModels
import UIKit

protocol CatchHomePresentableListener: AnyObject {
  func didTapLoginButton()
  func didTapCatchButton()
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

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    return stackView
  }()

  private let pokemonCardView = PokemonCardView()

  private lazy var catchButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(didTapCatchButton), for: .touchUpInside)
    button.layer.cornerRadius = 15
    button.layer.cornerCurve = .continuous
    button.clipsToBounds = true
    button.setBackgroundColor(.systemBlue, for: .normal)
    button.setTitle("Throw Pokémon ball!", for: .normal)
    button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
    return button
  }()

  weak var listener: CatchHomePresentableListener?

  private let imageLoader: ImageLoader

  init(imageLoader: ImageLoader) {
    self.imageLoader = imageLoader
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
    stackView.isHidden = false
  }

  func layoutLoggedOut() {
    logInButton.isHidden = false
    stackView.isHidden = true
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
    self.view.addSubview(stackView)

    stackView.addArrangedSubview(pokemonCardView)
    stackView.addArrangedSubview(catchButton)

    NSLayoutConstraint.activate([
      logInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
      logInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
      logInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      logInButton.heightAnchor.constraint(equalToConstant: 50),

      catchButton.heightAnchor.constraint(equalToConstant: 50),

      stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
      stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
      stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
      stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
    ])
  }

  @objc
  private func didTapLoginButton() {
    listener?.didTapLoginButton()
  }

  @objc
  private func didTapCatchButton() {
    listener?.didTapCatchButton()
  }

  func updatePokemonCardView(with pokemon: Pokemon) {
    pokemonCardView.nameLabel.text = pokemon.name

    Task {
      let pokemonImage = try await imageLoader.load(from: pokemon.imageURL)
      pokemonCardView.imageView.image = pokemonImage
      pokemonCardView.backgroundColor = pokemonImage.averageColor()
    }
  }
}

final class PokemonCardView: UIView {

  let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 20
    stackView.distribution = .fill
    return stackView
  }()

  let imageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .headline)
    label.textAlignment = .center
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    attribute()
    setupViews()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func attribute() {
    self.layer.cornerRadius = 30
    self.layer.borderWidth = 1
    self.clipsToBounds = true
  }

  private func setupViews() {
    self.addSubview(stackView)

    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(nameLabel)

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
      stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
      stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
    ])
  }
}
