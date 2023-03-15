import UIKit.UIImage

public protocol ImageCache {
  func get(forKey: String) -> UIImage?
  func set(forKey: String, image: UIImage)
}

public protocol ImageLoader {
  func load(from url: URL) async throws -> UIImage
}
