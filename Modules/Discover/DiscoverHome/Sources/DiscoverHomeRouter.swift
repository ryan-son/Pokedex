//
//  DiscoverHomeRouter.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import RIBs

protocol DiscoverHomeInteractable: Interactable {
  var router: DiscoverHomeRouting? { get set }
  var listener: DiscoverHomeListener? { get set }
}

protocol DiscoverHomeViewControllable: ViewControllable {}

final class DiscoverHomeRouter:
  ViewableRouter<DiscoverHomeInteractable, DiscoverHomeViewControllable>,
  DiscoverHomeRouting {

  override init(
    interactor: DiscoverHomeInteractable,
    viewController: DiscoverHomeViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
