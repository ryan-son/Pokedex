//
//  CatchHomeBuilder.swift
//  CatchHome
//
//  Created by Geonhee on 2023/03/13.
//

import ImageLoader
import PokemonRepository
import PXUtilities
import RIBs
import SharedModels

public protocol CatchHomeDependency: Dependency {
  var pokemonRepository: PokemonRepository { get }
  var imageLoader: ImageLoader { get }
  var user: ReadOnlyBehaviorSubject<User?> { get }
}

public protocol CatchHomeBuildable: Buildable {
  func build(withListener listener: CatchHomeListener) -> ViewableRouting
}

public protocol CatchHomeListener: AnyObject {
  func loginDidTapLoginButton(with user: User)
}
