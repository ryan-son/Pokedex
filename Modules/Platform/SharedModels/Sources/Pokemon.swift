//
//  APIService.swift
//  APIService
//
//  Created by Geonhee on 2023/03/11.
//

import Foundation

public struct Pokemon: Hashable {
  public let id: String
  public let name: String
  public let imageURL: URL

  public init(
    id: String,
    name: String,
    url: URL
  ) {
    self.id = id
    self.name = name
    self.imageURL = url
  }
}
