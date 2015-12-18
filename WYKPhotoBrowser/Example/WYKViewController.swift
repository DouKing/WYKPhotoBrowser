//
//  ViewController.swift
//  WYKPhotoBrowser
//
//  Created by WuYikai on 15/12/8.
//  Copyright © 2015年 secoo. All rights reserved.
//

import UIKit
import Kingfisher

class WYKViewController: UIViewController, WYKPhotoBrowserAnimatorDelegate {
  
  let smallImageURLs = ["http://pic.secooimg.com/thumb/112/112/pic1.secoo.com/comment/15/11/878ca70019fb4057ba9df62dea1d5bc0.jpg",
                        "http://pic.secooimg.com/thumb/112/112/pic1.secoo.com/comment/15/11/951c285b4ef34dffa2a30a08ce2e2b4a.jpg"]
  let bigImageURLs = ["http://pic.secooimg.com/comment/15/11/878ca70019fb4057ba9df62dea1d5bc0.jpg",
                      "http://pic.secooimg.com/comment/15/11/951c285b4ef34dffa2a30a08ce2e2b4a.jpg"]

  @IBOutlet weak var imageButton1: UIButton!
  @IBOutlet weak var imageButton2: UIButton!
  var photoBrowserAnimator: WYKPhotoBrowserAnimator?

  override func viewDidLoad() {
    super.viewDidLoad()
    imageButton1.backgroundColor = UIColor.yellowColor()
    imageButton1.kf_setBackgroundImageWithURL(NSURL(string: smallImageURLs[0])!, forState: .Normal)
    imageButton2.kf_setBackgroundImageWithURL(NSURL(string: smallImageURLs[1])!, forState: .Normal)
  }

  @IBAction func _handleTapImageButton(sender: UIButton) {
    let smallImages = [imageButton1.backgroundImageForState(.Normal), imageButton2.backgroundImageForState(.Normal)]
    let index = sender.tag - 1000
    photoBrowserAnimator = WYKPhotoBrowserAnimator(bigImageURLs: bigImageURLs, smallImages: smallImages)
    photoBrowserAnimator?.delegate = self
    photoBrowserAnimator?.show(fromIndex: index)
  }

  // MARK: - WYKPhotoBrowserAnimatorDelegate
  func wyk_photoBrowserAnimator(animator: WYKPhotoBrowserAnimator, frameAtScreenForIndex index: Int) -> CGRect {
    let tag = index + 1000
    let imageBtn = self.view.viewWithTag(tag)
    return self.view.convertRect((imageBtn?.frame)!, toView: UIApplication.sharedApplication().keyWindow)
  }
}

