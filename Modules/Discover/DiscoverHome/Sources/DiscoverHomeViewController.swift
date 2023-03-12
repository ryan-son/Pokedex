//
//  DiscoverHomeViewController.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import ImageLoader
import PokemonRepository
import RIBs
import RxSwift
import UIKit

protocol DiscoverHomePresentableListener: AnyObject {}

final class DiscoverHomeViewController: UIViewController, DiscoverHomePresentable, DiscoverHomeViewControllable {

  enum PokemonSection {
    case main
  }

  weak var listener: DiscoverHomePresentableListener?

  private lazy var pokemonsCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(
      PokemonCollectionViewCell.self,
      forCellWithReuseIdentifier: "PokemonCollectionViewCell"
    )
    return collectionView
  }()
  private var pokemonsDataSource: UICollectionViewDiffableDataSource<PokemonSection, Pokemon>?

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Discover Home"
    label.textColor = .label
    return label
  }()

  private let imageLoader: ImageLoader

  init(
    imageLoader: ImageLoader
  ) {
    self.imageLoader = imageLoader
    super.init(nibName: nil, bundle: nil)
    attribute()
    setupViews()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }

  private func attribute() {
    title = "Pokémons"
    self.view.backgroundColor = .systemGray6
    tabBarItem = UITabBarItem(
      title: "Discover",
      image: UIImage(systemName: "eyes.inverse"),
      selectedImage: UIImage(systemName: "eyes")
    )
  }

  private func setupViews() {
    setupPokemonsCollectionView()

    self.view.addSubview(pokemonsCollectionView)

    NSLayoutConstraint.activate([
      pokemonsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      pokemonsCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      pokemonsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      pokemonsCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }

  private func setupPokemonsCollectionView() {
    pokemonsDataSource = UICollectionViewDiffableDataSource<PokemonSection, Pokemon>(
      collectionView: pokemonsCollectionView
    ) { (collectionView, indexPath, pokemon) -> UICollectionViewCell? in
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "PokemonCollectionViewCell",
        for: indexPath
      ) as? PokemonCollectionViewCell else { fatalError("Could not dequeue cell") }
      cell.configure(with: pokemon, imageLoader: self.imageLoader)
      return cell
    }
  }

  private func createLayout() -> UICollectionViewLayout {
    let height: NSCollectionLayoutDimension = .absolute(180)
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.5),
      heightDimension: height
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: height
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem: item,
      count: 2
    )
    group.interItemSpacing = .fixed(10)

    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 10
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }

  func updateViews(with pokemons: [Pokemon]) {
    guard var snapshot = pokemonsDataSource?.snapshot() else { return }
    snapshot.deleteAllItems()
    snapshot.appendSections([.main])
    snapshot.appendItems(pokemons)
    pokemonsDataSource?.apply(snapshot, animatingDifferences: false)
  }
}

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
