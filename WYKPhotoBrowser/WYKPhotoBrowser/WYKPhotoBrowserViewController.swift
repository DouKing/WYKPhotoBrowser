//
//  WYKPhotoBrowserViewController.swift
//  WYKPhotoBrowser
//
//  Created by WuYikai on 15/12/9.
//  Copyright © 2015年 secoo. All rights reserved.
//

import UIKit

protocol WYKPhotoBrowserViewControllerDelegate {
  func wyk_photoBrowserViewController(viewController: WYKPhotoBrowserViewController, didTapImageView imageView: UIImageView)
}

class WYKPhotoBrowserViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  var delegate: WYKPhotoBrowserViewControllerDelegate?
  private var collectionView: UICollectionView!
  private var pageControl: UIPageControl!
  private var photos: [WYKPhoto]
  var currentIndex: Int

  // MARK: - life cycle
  init(photos: [WYKPhoto]) {
    currentIndex = 0
    self.photos = photos
    super.init(nibName: nil, bundle: nil)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupSubViews()
  }
  
  // MARK: - SubViews
  private func setupSubViews() {
    self.setupCollectionView()
    self.setupPageControl()
  }

  private func setupCollectionView() {
    let width = CGRectGetWidth(self.view.bounds) + kWYKPhotoImageViewInsert * 2
    let height = CGRectGetHeight(self.view.bounds)
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSizeMake(width, height)
    flowLayout.minimumInteritemSpacing = 0
    flowLayout.minimumLineSpacing = 0
    flowLayout.scrollDirection = .Horizontal
    
    let frame = CGRectMake(-kWYKPhotoImageViewInsert, 0, width, height)
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.pagingEnabled = true
    collectionView.alwaysBounceHorizontal = true
    collectionView.registerClass(WYKPhotoBrowserCell.self, forCellWithReuseIdentifier: kWYKPhotoBrowserCellId)
    self.view.addSubview(collectionView)
  }
  
  private func setupPageControl() {
    
  }
  
  // MARK: - UICollectionViewDataSource & UICollectionViewDelegate
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.photos.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kWYKPhotoBrowserCellId, forIndexPath: indexPath) as! WYKPhotoBrowserCell
    cell.setupWith(photo: self.photos[indexPath.item])
    return cell
  }

  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let cell = collectionView.cellForItemAtIndexPath(indexPath) as! WYKPhotoBrowserCell
    self.delegate?.wyk_photoBrowserViewController(self, didTapImageView: cell.imageView)
  }
}

// MARK: - WYKPhotoBrowserCell -

private let kWYKPhotoBrowserCellId = "kWYKPhotoBrowserCellId"
private let kWYKPhotoImageViewInsert: CGFloat = 5.0

private class WYKPhotoBrowserCell: UICollectionViewCell, UIScrollViewDelegate {
  var imageView: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self._setupImageView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupWith(photo photo: WYKPhoto) {
    self.imageView.kf_setImageWithURL(NSURL(string: photo.imageURL)!, placeholderImage: photo.smallImage)
  }
  
  // MARK: - Private Methods
  
  func _setupImageView() {
    let width = CGRectGetWidth(self.contentView.bounds)
    let height = CGRectGetHeight(self.contentView.bounds)
    let frame = CGRectMake(kWYKPhotoImageViewInsert, 0, width - kWYKPhotoImageViewInsert * 2, height)
    
    imageView = UIImageView(frame: frame)
    imageView.backgroundColor = UIColor.clearColor()
    imageView.contentMode = .ScaleAspectFit
    imageView.clipsToBounds = true
    imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    self.contentView.addSubview(imageView)
  }
}

