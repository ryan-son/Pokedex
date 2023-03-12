import APIService
import Foundation
import RxSwift
import SharedModels

public protocol PokemonRepository {
  var pokemons: Observable<[Pokemon]> { get }

  func fetchPokemons()
}

public final class PokemonRepositoryImpl: PokemonRepository {

  private let apiService: APIService
  private let baseURL: URL
  private var disposeBag: DisposeBag

  private var pokemonsSubject = BehaviorSubject<[Pokemon]>(value: [])
  public var pokemons: Observable<[Pokemon]> { pokemonsSubject.asObservable() }

  public init(
    apiService: APIService,
    baseURL: URL
  ) {
    self.disposeBag = DisposeBag()
    self.apiService = apiService
    self.baseURL = baseURL
  }

  public func fetchPokemons() {
    let request = PokemonsRequest(
      baseURL: baseURL,
      limit: 20
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
        onSuccess: { [weak self] pokemons in
          self?.pokemonsSubject.onNext(pokemons)
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }
}
