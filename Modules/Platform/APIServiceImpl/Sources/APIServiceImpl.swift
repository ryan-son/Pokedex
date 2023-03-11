import APIService
import Foundation
import RxCocoa
import RxSwift

public final class APIServiceImpl: APIService {

  private let session: URLSession

  public init(session: URLSession) {
    self.session = session
  }

  public func send<T>(_ request: T) -> Single<Result<Response<T.Output>, Error>> where T: Request {
    return Single.create { observer in
      do {
        let urlRequest = try RequestFactory(request: request).urlRequestRepresentation()

        let task = self.session.dataTask(with: urlRequest) { (data, response, error) in
          if let error {
            observer(.failure(error))
            return
          }

          guard let response = response as? HTTPURLResponse else {
            observer(.failure(APIServiceError.invalidResponse))
            return
          }

          guard let data else {
            observer(.failure(APIServiceError.invalidData))
            return
          }

          do {
            let output = try JSONDecoder().decode(T.Output.self, from: data)
            let response = Response(output: output, statusCode: response.statusCode)
            observer(.success(.success(response)))
          } catch {
            observer(.failure(error))
          }
        }
        task.resume()

        return Disposables.create {
          task.cancel()
        }
      } catch {
        observer(.failure(error))
      }

      return Disposables.create()
    }
  }
}

private final class RequestFactory<T: Request> {

  let request: T
  private var urlComponents: URLComponents?

  init(request: T) {
    self.request = request
    self.urlComponents = URLComponents(url: request.endpoint, resolvingAgainstBaseURL: true)
  }

  func urlRequestRepresentation() throws -> URLRequest {
    switch request.method {
    case .get:
      return try makeGetRequest()
    case .post:
      return try makePostRequest()
    }
  }

  private func makeGetRequest() throws -> URLRequest {
    if request.query.isEmpty == false {
      urlComponents?.queryItems = request.query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
    return try makeURLRequest()
  }

  private func makePostRequest() throws -> URLRequest {
    let body = try JSONSerialization.data(withJSONObject: request.query, options: [])
    return try makeURLRequest(httpBody: body)
  }

  private func makeURLRequest(httpBody: Data? = nil) throws -> URLRequest {
    guard let url = urlComponents?.url else {
      throw APIServiceError.invalidURL(url: request.endpoint.absoluteString)
    }

    var urlRequest = URLRequest(url: url)
    request.header.forEach {
      urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
    }
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.httpBody = httpBody

    return urlRequest
  }
}
