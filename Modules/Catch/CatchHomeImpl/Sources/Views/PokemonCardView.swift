//
//  PokemonCardView.swift
//  CatchHomePreviewApp
//
//  Created by Geonhee on 2023/03/15.
//

import UIKit

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
