//
//  AppComponent.swift
//  PokedexApp
//
//  Created by Geonhee on 2023/03/09.
//

import RIBs

final class AppComponent: Component<EmptyDependency>, AppRootDependency {

  init() {
    super.init(dependency: EmptyComponent())
  }
}
