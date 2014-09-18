//
//  CustomScrollViewController.swift
//  ScrollViews
//
//  Created by Roma Sosnovsky on 8/27/14.
//  Copyright (c) 2014 Roma Sosnovsky. All rights reserved.
//

import UIKit

class CustomScrollViewController: UIViewController, UIScrollViewDelegate {

  @IBOutlet weak var scrollView: UIScrollView!
  var containerView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    view.addSubview(scrollView)
    scrollView.delegate = self
    
    let containerSize = CGSize(width: 640, height: 640)
    containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: containerSize))
    scrollView.addSubview(containerView)
    
    let blueView = UIView(frame: CGRectMake(0, 0, 640, 80))
    blueView.backgroundColor = UIColor.blueColor()
    containerView.addSubview(blueView)
    
    let redView = UIView(frame: CGRectMake(0, 560, 640, 80))
    redView.backgroundColor = UIColor.redColor()
    containerView.addSubview(redView)
    
    let greenView = UIView(frame: CGRectMake(160, 160, 320, 320))
    greenView.backgroundColor = UIColor.greenColor()
    containerView.addSubview(greenView)
    
    let imageView = UIImageView(image: UIImage(named: "slow"))
    imageView.center = CGPointMake(320, 320)
    containerView.addSubview(imageView)
    
    scrollView.contentSize = containerSize
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    let scrollViewFrame = scrollView.frame
    let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
    let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
    let minScale = min(scaleHeight, scaleWidth)
    
    scrollView.minimumZoomScale = minScale
    scrollView.maximumZoomScale = 1
    scrollView.zoomScale = 1
    
    centerScrollViewContents()
  }
  
  func centerScrollViewContents() {
    let boundsSize = scrollView.bounds.size
    var contentsFrame = containerView.frame
    
    if contentsFrame.size.width < boundsSize.width {
      contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2
    } else {
      contentsFrame.origin.x = 0
    }
    
    if contentsFrame.size.height < boundsSize.height {
      contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2
    } else {
      contentsFrame.origin.y = 0
    }
    
    containerView.frame = contentsFrame
  }
  
  func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
    return containerView
  }
  
  func scrollViewDidZoom(scrollView: UIScrollView!) {
    self.centerScrollViewContents()
  }
  
}
