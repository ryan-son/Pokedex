//
//  UIImage+Extensions.swift
//  PXUtilities
//
//  Created by Geonhee on 2023/03/13.
//

import UIKit
import CoreImage

public extension UIImage {
  func averageColor() -> UIColor? {
    guard let inputImage = CIImage(image: self) else { return nil }

    let extentVector = CIVector(
      x: inputImage.extent.origin.x,
      y: inputImage.extent.origin.y,
      z: inputImage.extent.size.width,
      w: inputImage.extent.size.height
    )
    let filter = CIFilter(
      name: "CIAreaAverage",
      parameters: [kCIInputImageKey: inputImage,
      kCIInputExtentKey: extentVector]
    )
    guard let filter,
          let outputImage = filter.outputImage else { return nil }

    let context = CIContext()
    var bitmap = [UInt8](repeating: 0, count: 4)
    context.render(
      outputImage,
      toBitmap: &bitmap,
      rowBytes: 4,
      bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
      format: .RGBA8,
      colorSpace: nil
    )

    let red = CGFloat(bitmap[0]) * 2.5 / 255.0
    let green = CGFloat(bitmap[1]) * 2.5 / 255.0
    let blue = CGFloat(bitmap[2]) * 2.5 / 255.0

    return UIColor(red: red, green: green, blue: blue, alpha: 0.7)
  }
}
