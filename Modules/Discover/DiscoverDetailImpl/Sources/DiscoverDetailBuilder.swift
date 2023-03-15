//
//  DiscoverDetailBuilder.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

import DiscoverDetail
import ImageLoader
import RIBs
import SharedModels

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
