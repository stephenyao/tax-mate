//
//  UIImage+Utils.swift
//  tax-mate
//
//  Created by Stephen Yao on 18/2/22.
//

import Foundation
import UIKit

extension UIImage {
  func normalizedImage() -> UIImage {
    if (self.imageOrientation == UIImage.Orientation.up) {
      return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
    let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
    self.draw(in: rect)
    
    let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    UIGraphicsEndImageContext();
    return normalizedImage;
  }
  
  func resized(to newSize: CGSize) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
    defer { UIGraphicsEndImageContext() }
    
    draw(in: CGRect(origin: .zero, size: newSize))
    return UIGraphicsGetImageFromCurrentImageContext()!
  }
}
