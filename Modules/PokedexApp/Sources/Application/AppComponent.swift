//
//  AppComponent.swift
//  PokedexApp
//
//  Created by Geonhee on 2023/03/09.
//

import APIService
import APIServiceImpl
import ImageLoader
import PokemonRepository
import PokemonRepositoryImpl
import RIBs
import RxSwift
import SharedModels

final class AppComponent: Component<EmptyDependency>, AppRootDependency {

  let apiService = APIServiceImpl(session: .shared)
  lazy var pokemonRepository: PokemonRepository = PokemonRepositoryImpl(
    apiService: apiService,
    baseURL: BaseURL.pokemon
  )
  let imageLoader: ImageLoader = ImageLoaderImpl(
    session: .shared,
    cache: MemoryCache()
  )
  let userSubject = BehaviorSubject<User?>(value: nil)

  init() {
    super.init(dependency: EmptyComponent())
  }
}
