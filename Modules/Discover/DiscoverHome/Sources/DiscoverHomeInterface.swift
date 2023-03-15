//
//  DiscoverHomeBuilder.swift
//  DiscoverHome
//
//  Created by Geonhee on 2023/03/10.
//

import DiscoverDetail
import ImageLoader
import PokemonRepository
import PXUtilities
import RIBs
import SharedModels

public protocol DiscoverHomeDependency: Dependency {
  var discoverDetailBuilder: DiscoverDetailBuildable { get }
  var pokemonRepository: PokemonRepository { get }
  var imageLoader: ImageLoader { get }
  var user: ReadOnlyBehaviorSubject<User?> { get }
}

public protocol DiscoverHomeBuildable: Buildable {
  func build(
    withListener listener: DiscoverHomeListener
  ) -> ViewableRouting
}

public protocol DiscoverHomeListener: AnyObject {}
