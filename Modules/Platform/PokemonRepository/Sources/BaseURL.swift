//
//  BaseURL.swift
//  PokemonRepository
//
//  Created by Geonhee on 2023/03/12.
//

import Foundation

public enum BaseURL {
  public static var pokemon: URL {
    return URL(string: "https://pokeapi.co/api/v2")!
  }
}
