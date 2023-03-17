//
//  AppComponent.swift
//  PokedexApp
//
//  Created by Geonhee on 2023/03/09.
//

import APIService
import APIServiceImpl
import CatchHome
import CatchHomeImpl
import DiscoverHome
import DiscoverHomeImpl
import DiscoverDetail
import DiscoverDetailImpl
import ImageLoader
import ImageLoaderImpl
import Login
import LoginImpl
import PokemonRepository
import PokemonRepositoryImpl
import PXUtilities
import RIBs
import RxSwift
import SharedModels

final class AppComponent:
  Component<EmptyDependency>,
  AppRootDependency,
  CatchHomeDependency,
  DiscoverHomeDependency,
  DiscoverDetailDependency,
  LoginDependency {

  lazy var catchHomeBuilder: CatchHomeBuildable = {
    return CatchHomeBuilder(dependency: self)
  }()
  lazy var discoverHomeBuilder: DiscoverHomeBuildable = {
    return DiscoverHomeBuilder(dependency: self)
  }()
  lazy var discoverDetailBuilder: DiscoverDetailBuildable = {
    return DiscoverDetailBuilder(dependency: self)
  }()
  lazy var loginBuilder: LoginBuildable = {
    return LoginBuilder(dependency: self)
  }()

  let apiService = APIServiceImpl(session: .shared)
  let mainQueue: ImmediateSchedulerType = MainScheduler.instance
  lazy var pokemonRepository: PokemonRepository = PokemonRepositoryImpl(
    apiService: apiService,
    baseURL: BaseURL.pokemon
  )
  let imageLoader: ImageLoader = ImageLoaderImpl(
    session: .shared,
    cache: MemoryCache()
  )
  let userSubject = BehaviorSubject<User?>(value: nil)
  var user: ReadOnlyBehaviorSubject<User?> { ReadOnlyBehaviorSubject(for: userSubject) }

  init() {
    super.init(dependency: EmptyComponent())
  }
}
