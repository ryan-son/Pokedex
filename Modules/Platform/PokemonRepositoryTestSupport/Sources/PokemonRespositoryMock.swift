import Foundation
import PokemonRepository
import PXUtilities
import RxSwift
import SharedModels

public final class PokemonRepositoryMock: PokemonRepository {

  public var pokemonsSubject = BehaviorSubject<[Pokemon]>(value: [])
  public var pokemons: ReadOnlyBehaviorSubject<[Pokemon]> {
    return ReadOnlyBehaviorSubject(for: pokemonsSubject)
  }

  public var fetchPokemonsCallCount = 0
  public var fetchPokemonsLimit = 0
  public func fetchPokemons(limit: Int) {
    fetchPokemonsCallCount += 1
    fetchPokemonsLimit = limit
    let pokemon = Pokemon(
      id: "0",
      name: "Squirtle",
      url: URL(string: "https://squirtle.com")!
    )
    let pokemons = Array(repeating: pokemon, count: 20)
    pokemonsSubject.onNext(pokemons)
  }

  public var randomPokemonCallCount = 0
  public func randomPokemon(
    selectRandom: @escaping (([Pokemon]) -> Pokemon?)
  ) -> Pokemon? {
    randomPokemonCallCount += 1
    return selectRandom(pokemons.value ?? [])
  }

  public init() {}
}
