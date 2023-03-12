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
import RIBs

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

  init() {
    super.init(dependency: EmptyComponent())
  }
}
