//
//  PokemonCollectionViewCell.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/12.
//

import ImageLoader
import PXDesignSystem
import PXUtilities
import SharedModels
import UIKit

final class PokemonCollectionViewCell: UICollectionViewCell, Reusable {

  let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 10
    stackView.distribution = .fill
    return stackView
  }()

  let thumbnailImageView = {
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

  private var imageLoader: ImageLoader?

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.contentView.addSubview(stackView)

    stackView.addArrangedSubview(thumbnailImageView)
    stackView.addArrangedSubview(nameLabel)

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
      stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
      stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
    ])

    contentView.layer.cornerRadius = 30
    contentView.layer.borderWidth = 1
    contentView.clipsToBounds = true
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    //      imageLoader?.cancel()
    contentView.backgroundColor = nil
    thumbnailImageView.image = nil
  }

  func configure(with pokemon: Pokemon, imageLoader: ImageLoader) {
    self.imageLoader = imageLoader
    nameLabel.text = pokemon.name.capitalized

    Task {
      let pokemonImage = try await imageLoader.load(from: pokemon.imageURL)
      self.thumbnailImageView.image = pokemonImage
      self.contentView.backgroundColor = pokemonImage.averageColor()
    }
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
