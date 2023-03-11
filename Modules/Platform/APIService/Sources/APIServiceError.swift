//
//  APIServiceError.swift
//  APIService
//
//  Created by Geonhee on 2023/03/11.
//

import Foundation

public enum APIServiceError: Error {
  case invalidData
  case invalidResponse
  case invalidURL(url: String?)
}
