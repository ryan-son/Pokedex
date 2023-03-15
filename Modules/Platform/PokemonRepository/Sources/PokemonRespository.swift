import Foundation
import PXUtilities
import RxSwift
import SharedModels

public protocol PokemonRepository {
  var pokemons: ReadOnlyBehaviorSubject<[Pokemon]> { get }

  func fetchPokemons(limit: Int)
  func randomPokemon() -> Pokemon?
}
