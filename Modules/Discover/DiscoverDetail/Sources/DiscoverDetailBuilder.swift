//
//  DiscoverDetailBuilder.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

import ImageLoader
import SharedModels
import RIBs

public protocol DiscoverDetailDependency: Dependency {
  var imageLoader: ImageLoader { get }
}

final class DiscoverDetailComponent: Component<DiscoverDetailDependency>, DiscoverDetailInteractorDependency {
  fileprivate let selectedPokemon: Pokemon
  var imageLoader: ImageLoader { dependency.imageLoader }

  init(
    dependency: DiscoverDetailDependency,
    selectedPokemon: Pokemon
  ) {
    self.selectedPokemon = selectedPokemon
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

public protocol DiscoverDetailBuildable: Buildable {
  func build(
    withListener listener: DiscoverDetailListener,
    selectedPokemon: Pokemon
  ) -> ViewableRouting
}

public final class DiscoverDetailBuilder: Builder<DiscoverDetailDependency>, DiscoverDetailBuildable {

  public override init(dependency: DiscoverDetailDependency) {
    super.init(dependency: dependency)
  }

  public func build(
    withListener listener: DiscoverDetailListener,
    selectedPokemon: Pokemon
  ) -> ViewableRouting {
    let component = DiscoverDetailComponent(dependency: dependency, selectedPokemon: selectedPokemon)
    let viewController = DiscoverDetailViewController(
      imageLoader: component.imageLoader,
      pokemon: component.selectedPokemon
    )
    let interactor = DiscoverDetailInteractor(presenter: viewController)
    interactor.listener = listener
    return DiscoverDetailRouter(interactor: interactor, viewController: viewController)
  }
}
