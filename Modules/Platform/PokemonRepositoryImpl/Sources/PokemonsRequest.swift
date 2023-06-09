//
//  PokemonsRequest.swift
//  PokemonRepository
//
//  Created by Geonhee on 2023/03/12.
//

import APIService
import Foundation
import SharedModels

struct PokemonsRequest: Request {

  typealias Output = PokemonsResponse

  var endpoint: URL
  var method: HTTPMethod
  var query: QueryItems
  var header: HTTPHeader

  init(
    baseURL: URL,
    limit: Int,
    offset: Int
  ) {
    self.endpoint = baseURL.appendingPathComponent("/pokemon/")
    self.method = .get
    self.query = [
      "limit": limit,
      "offset": offset,
    ]
    self.header = [:]
  }
}

struct PokemonsResponse: Decodable {
  let results: [PokemonResponseDTO]
}

public struct PokemonResponseDTO: Decodable {
  static let imageBaseURL = URL(
    string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork"
  )!
  let name: String
  let url: URL
}

extension PokemonResponseDTO {
  func toDomain() -> Pokemon {
    let id = String(url.absoluteString.split(separator: "/").last ?? "")
    return Pokemon(
      id: id,
      name: name,
      url: Self.imageBaseURL.appendingPathComponent("\(id).png")
    )
  }
}
