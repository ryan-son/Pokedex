import UIKit

public protocol ImageCache {
  func get(forKey: String) -> UIImage?
  func set(forKey: String, image: UIImage)
}

public final class MemoryCache: ImageCache {
  private let cache = NSCache<NSString, UIImage>()

  public func get(forKey: String) -> UIImage? {
    return cache.object(forKey: NSString(string: forKey))
  }

  public func set(forKey: String, image: UIImage) {
    cache.setObject(image, forKey: NSString(string: forKey))
  }

  public init() {}
}

public protocol ImageLoader {
  func load(from url: URL) async throws -> UIImage
}

public final class ImageLoaderImpl: ImageLoader {
  private let session: URLSession
  private let cache: ImageCache

  public init(
    session: URLSession,
    cache: ImageCache
  ) {
    self.session = session
    self.cache = cache
  }

  public func load(from url: URL) async throws -> UIImage {
    if let image = cache.get(forKey: url.absoluteString) {
      return image
    } else {
      let (data, response) = try await session.data(for: URLRequest(url: url))
      guard let image = UIImage(data: data) else {
        throw ImageLoadError.invalidData
      }
      self.cache.set(forKey: url.absoluteString, image: image)
      return image
    }
  }
}

enum ImageLoadError: Error {
  case invalidData
}
