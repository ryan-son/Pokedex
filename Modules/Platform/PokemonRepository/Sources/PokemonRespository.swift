import APIService
import Foundation
import PXUtilities
import RIBsUtil
import RxSwift
import SharedModels

public protocol PokemonRepository {
  var pokemons: ReadOnlyBehaviorSubject<[Pokemon]> { get }

  func fetchPokemons(limit: Int)
}

public final class PokemonRepositoryImpl: PokemonRepository {

  private let apiService: APIService
  private let baseURL: URL
  private var disposeBag: DisposeBag

  private var pokemonsSubject = BehaviorSubject<[Pokemon]>(value: [])
  public var pokemons: ReadOnlyBehaviorSubject<[Pokemon]> {
    return ReadOnlyBehaviorSubject(for: pokemonsSubject)
  }
  private var currentOffset: Int = 1
  private var isLoading: Bool = false

  public init(
    apiService: APIService,
    baseURL: URL
  ) {
    self.disposeBag = DisposeBag()
    self.apiService = apiService
    self.baseURL = baseURL
  }

  public func fetchPokemons(limit: Int) {
    guard isLoading == false else { return }

    isLoading = true

    let request = PokemonsRequest(
      baseURL: baseURL,
      limit: limit,
      offset: currentOffset
    )
    apiService.send(request)
      .map { result in
        switch result {
        case let .success(response):
          guard var newPokemons = (try? self.pokemonsSubject.value()) else { return [] }
          newPokemons.append(contentsOf: response.output.results.map { $0.toDomain() })
          return newPokemons
        case let .failure(error):
          throw error
        }
      }
      .subscribe(
        onSuccess: { [weak self] (pokemons: [Pokemon]) in
          self?.isLoading = false
          self?.currentOffset += limit
          self?.pokemonsSubject.onNext(pokemons)
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }
}
