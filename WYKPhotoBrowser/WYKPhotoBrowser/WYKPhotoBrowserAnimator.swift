//
//  WYKPhotoBrowserAnimator.swift
//  WYKPhotoBrowser
//
//  Created by WuYikai on 15/12/9.
//  Copyright © 2015年 secoo. All rights reserved.
//

import UIKit

public protocol WYKPhotoBrowserAnimatorDelegate {
  func wyk_photoBrowserAnimator(animator: WYKPhotoBrowserAnimator, frameAtScreenForIndex index: Int) -> CGRect
}

public class WYKPhotoBrowserAnimator: NSObject, WYKPhotoBrowserViewControllerDelegate {
  
  public var delegate: WYKPhotoBrowserAnimatorDelegate?
  private var bigImageURLs: [String]
  private var smallImages: [UIImage?]
  private var photos: [WYKPhoto]
  
  public init(bigImageURLs: [String], smallImages: [UIImage?]) {
    self.bigImageURLs = bigImageURLs
    self.smallImages = smallImages
    self.photos = [WYKPhoto]()
    for var i = 0; i < bigImageURLs.count; ++i {
      let photo = WYKPhoto()
      photo.imageURL = bigImageURLs[i]
      photo.smallImage = smallImages[i]
      self.photos.append(photo)
    }
    super.init()
  }
  
  public func show(fromIndex fromIndex: Int = 0) {
    let vc = WYKPhotoBrowserViewController(photos: self.photos)
    vc.modalPresentationStyle = .Custom
    vc.delegate = self
    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
  }
  
  // MARK: - WYKPhotoBrowserViewControllerDelegate
  func wyk_photoBrowserViewController(viewController: WYKPhotoBrowserViewController, didTapImageView imageView: UIImageView) {
    viewController.dismissViewControllerAnimated(true, completion: nil)
  }
}

public class WYKPhoto: NSObject {
  var imageURL: String!
  var smallImage: UIImage?
}