//
//  PokemonCollectionViewCell.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/12.
//

import ImageLoader
import SharedModels
import UIKit

final class PokemonCollectionViewCell: UICollectionViewCell {

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
      stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
    ])

    contentView.layer.cornerRadius = 20
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = UIColor.gray.cgColor
    contentView.clipsToBounds = true
  }

  override func prepareForReuse() {
      super.prepareForReuse()

//      imageLoader?.cancel()
      thumbnailImageView.image = nil
  }

  func configure(with pokemon: Pokemon, imageLoader: ImageLoader) {
    self.imageLoader = imageLoader
    nameLabel.text = pokemon.name.capitalized

    Task {
      self.thumbnailImageView.image = try await imageLoader.load(from: pokemon.imageURL)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
