//
//  DiscoverDetailRouter.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

import RIBs

protocol DiscoverDetailInteractable: Interactable {
  var router: DiscoverDetailRouting? { get set }
  var listener: DiscoverDetailListener? { get set }
}

protocol DiscoverDetailViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class DiscoverDetailRouter: ViewableRouter<DiscoverDetailInteractable, DiscoverDetailViewControllable>, DiscoverDetailRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  override init(interactor: DiscoverDetailInteractable, viewController: DiscoverDetailViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}
