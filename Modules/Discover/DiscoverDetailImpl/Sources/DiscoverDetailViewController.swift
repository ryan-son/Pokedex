//
//  DiscoverDetailViewController.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

import ImageLoader
import RIBs
import RxSwift
import SharedModels
import UIKit

protocol DiscoverDetailPresentableListener: AnyObject {
  func didTapBackButton()
}

final class DiscoverDetailViewController:
  UIViewController,
  DiscoverDetailPresentable,
  DiscoverDetailViewControllable {

  weak var listener: DiscoverDetailPresentableListener?

  private let pokemonImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let imageLoader: ImageLoader
  private let pokemon: Pokemon

  init(
    imageLoader: ImageLoader,
    pokemon: Pokemon
  ) {
    self.imageLoader = imageLoader
    self.pokemon = pokemon
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
    setupViews()
    setPokemonImage()
  }

  private func attribute() {
    self.title = pokemon.name.capitalized
    self.view.backgroundColor = .systemBackground
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(
        systemName: "chevron.backward",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
      ),
      style: .plain,
      target: self,
      action: #selector(didTapBackButton)
    )

    if let navigationController = self.navigationController {
      navigationController.interactivePopGestureRecognizer?.delegate = nil
    }
    navigationController?.interactivePopGestureRecognizer?.addTarget(
      self,
      action: #selector(didTapBackButton)
    )
  }

  private func setupViews() {
    self.view.addSubview(pokemonImageView)

    NSLayoutConstraint.activate([
      pokemonImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
      pokemonImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
      pokemonImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
      pokemonImageView.heightAnchor.constraint(equalToConstant: 350),
    ])
  }

  private func setPokemonImage() {
    Task {
      pokemonImageView.image = try await imageLoader.load(from: pokemon.imageURL)
    }
  }

  @objc
  private func didTapBackButton() {
    listener?.didTapBackButton()
  }
}
