//
//  ImageScrollViewController.swift
//  ScrollViews
//
//  Created by Roma Sosnovsky on 8/27/14.
//  Copyright (c) 2014 Roma Sosnovsky. All rights reserved.
//

import UIKit

class ImageScrollViewController: UIViewController, UIScrollViewDelegate {
    
  let scrollView = UIScrollView()
  let imageView = UIImageView()
  var navbarOffset = CGFloat(0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateNavbarOffset()
    
    imageView.image = UIImage(named: "photo-1")
    imageView.hidden = true
    
    view.addSubview(scrollView)
    scrollView.addSubview(imageView)
    scrollView.delegate = self
    
    scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
    imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    var viewsDictionary: NSMutableDictionary = NSMutableDictionary()
    viewsDictionary.setValue(scrollView, forKey: "scrollView")
    viewsDictionary.setValue(imageView, forKey: "imageView")
    
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: nil, metrics: nil, views: viewsDictionary))
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: nil, metrics: nil, views: viewsDictionary))
    scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: nil, metrics: nil, views: viewsDictionary))
    scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: nil, metrics: nil, views: viewsDictionary))
    
    let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("scrollViewDoubleTapped:"))
    doubleTapRecognizer.numberOfTapsRequired = 2
    doubleTapRecognizer.numberOfTouchesRequired = 1
    scrollView.addGestureRecognizer(doubleTapRecognizer)
    
    let twoFingerTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("scrollViewTwoFingerTapped:"))
    twoFingerTapRecognizer.numberOfTapsRequired = 1
    twoFingerTapRecognizer.numberOfTouchesRequired = 2
    scrollView.addGestureRecognizer(twoFingerTapRecognizer)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    let scaleWidth = scrollView.frame.size.width / imageView.frame.width
    let scaleHeight = scrollView.frame.size.height / imageView.frame.height
    let minScale = min(scaleWidth, scaleHeight)
    
    scrollView.minimumZoomScale = minScale
    scrollView.maximumZoomScale = 1
    scrollView.zoomScale = minScale
    
    centerScrollViewContents()
  }
  
  override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
    updateNavbarOffset()
    centerScrollViewContents()
  }
  
  func centerScrollViewContents() {
    let boundsSize = scrollView.bounds.size
    var contentsFrame = imageView.frame
    
    if contentsFrame.size.width < boundsSize.width {
      contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2
    } else {
      contentsFrame.origin.x = 0
    }
    
    if contentsFrame.size.height < boundsSize.height {
      contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height - navbarOffset) / 2
    } else {
      contentsFrame.origin.y = 0
    }
    
    imageView.frame = contentsFrame
    imageView.hidden = false
  }
  
  func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
    let pointInView = recognizer.locationInView(imageView)
    
    var newZoomScale = scrollView.zoomScale * 1.5
    newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
    
    let scrollViewSize = scrollView.bounds.size
    let w = scrollViewSize.width / newZoomScale
    let h = scrollViewSize.height / newZoomScale
    let x = pointInView.x - (w / 2)
    let y = pointInView.y - (h / 2)
    
    let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h)
    scrollView.zoomToRect(rectToZoomTo, animated: true)
  }
  
  func scrollViewTwoFingerTapped(recognizer: UITapGestureRecognizer) {
    var newZoomScale = scrollView.zoomScale / 1.5
    newZoomScale = max(newZoomScale, scrollView.minimumZoomScale)
    scrollView.setZoomScale(newZoomScale, animated: true)
  }
  
  func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
    return imageView
  }

  func updateNavbarOffset() -> Void {
    navbarOffset = navigationController.navigationBar.frame.size.height + navigationController.navigationBar.frame.origin.y
  }

  func scrollViewDidZoom(scrollView: UIScrollView!) {
    centerScrollViewContents()
  }
  
}
