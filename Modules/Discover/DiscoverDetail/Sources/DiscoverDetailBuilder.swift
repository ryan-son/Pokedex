//
//  DiscoverDetailBuilder.swift
//  DiscoverDetail
//
//  Created by Geonhee on 2023/03/13.
//

import ImageLoader
import RIBs
import SharedModels

public protocol DiscoverDetailDependency: Dependency {
  var imageLoader: ImageLoader { get }
}

public protocol DiscoverDetailBuildable: Buildable {
  func build(
    withListener listener: DiscoverDetailListener,
    selectedPokemon: Pokemon
  ) -> ViewableRouting
}

public protocol DiscoverDetailListener: AnyObject {
  func discoverDetailDidTapBackButton()
}
