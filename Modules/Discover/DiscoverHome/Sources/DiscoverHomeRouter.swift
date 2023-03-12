//
//  DiscoverHomeRouter.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import DiscoverDetail
import RIBs
import SharedModels

protocol DiscoverHomeInteractable: Interactable, DiscoverDetailListener {
  var router: DiscoverHomeRouting? { get set }
  var listener: DiscoverHomeListener? { get set }
}

protocol DiscoverHomeViewControllable: ViewControllable {}

final class DiscoverHomeRouter:
  ViewableRouter<DiscoverHomeInteractable, DiscoverHomeViewControllable>,
  DiscoverHomeRouting {

  private let discoverDetailBuilder: DiscoverDetailBuildable
  private var discoverDetailRouter: ViewableRouting?

  init(
    interactor: DiscoverHomeInteractable,
    viewController: DiscoverHomeViewControllable,
    discoverDetailBuilder: DiscoverDetailBuildable
  ) {
    self.discoverDetailBuilder = discoverDetailBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  func routeToDiscoverDetail(selectedPokemon: Pokemon) {
    guard discoverDetailRouter == nil else { return }

    let router = discoverDetailBuilder.build(
      withListener: interactor,
      selectedPokemon: selectedPokemon
    )
    viewController.pushViewController(router.viewControllable, animated: true)
    discoverDetailRouter = router
    attachChild(router)
  }

  func detachDiscoverDetail() {
    guard let router = discoverDetailRouter else { return }

    viewController.popViewController(animated: true)
    discoverDetailRouter = nil
    detachChild(router)
  }
}
