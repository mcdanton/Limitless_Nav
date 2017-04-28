//
//  ScrollView.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/21/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class ScrollView: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {
   
   // MARK: Outlets
   @IBOutlet var superView: UIView!
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var contentView: UIView!
   @IBOutlet weak var pageControl: UIPageControl!
   
   // MARK: Properties
   var currentView: UIView!
   var newView: UIView!
   var activeView: UIView!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      scrollView.delegate = self
      
      setupInitialSlides()
      
      scrollView.contentSize = CGSize(width: contentView.frame.width * CGFloat(totalNumberOfPages()), height: view.frame.height)
      
      scrollView.isPagingEnabled = true
      pageControl.numberOfPages = totalNumberOfPages()
      pageControl.currentPage = 0
      
      view.bringSubview(toFront: pageControl)
      
      addGestures()
   }
   
   
   func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
      if gestureRecognizer.state == .began  {
      print("press confirmed")
      
         contentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
         addPage()
         
      } else if gestureRecognizer.state == .ended {
         print("press ended")
         
     contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
      }
   }
   
   func setupInitialSlides() {
      currentView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
      currentView.translatesAutoresizingMaskIntoConstraints = false
      currentView.backgroundColor = UIColor.red
      contentView.addSubview(currentView)
      
      newView = UIView(frame: CGRect(x: currentView.frame.origin.x + currentView.frame.width, y: currentView.frame.origin.y, width: currentView.frame.width, height: currentView.frame.height))
      newView.backgroundColor = UIColor.green
      contentView.addSubview(newView)

      
   }
   
   func addGestures() {
      let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
      longPress.minimumPressDuration = 0.1
      longPress.delegate = self
      self.view.addGestureRecognizer(longPress)
      
      let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(switchScreens))
      swipeLeft.direction = .left
      swipeLeft.delegate = self
      //self.view.addGestureRecognizer(swipeLeft)
   }
   
   
   func switchScreens(gestureRecognizer: UISwipeGestureRecognizer) {
      print("Swipe recognized")
      
      UIView.animate(withDuration: 1.0, animations: {
         self.newView?.frame = self.view.frame
         self.newView?.backgroundColor =  UIColor.cyan
         self.activeView = self.newView
      }, completion: nil)
      
   }
   
   
   func contentViewInferredSize(numbOfPages: Int) -> CGSize {
      
      let adjustedSize = CGSize(width: view.frame.width * CGFloat(numbOfPages), height: view.frame.height)
      return adjustedSize
   }
   
   func totalNumberOfPages() -> Int {
      var numberOfPages = 0
      for _ in contentView.subviews {
         numberOfPages += 1
      }
      return numberOfPages
   }
   
   func addPage() {
      
      let newPage = UIView(frame: CGRect(x: view.frame.width * CGFloat(totalNumberOfPages()), y: 0, width: view.frame.width, height: view.frame.height))
      newPage.backgroundColor = UIColor.random()
      contentView.addSubview(newPage)
      scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(totalNumberOfPages()), height: view.frame.height)
      pageControl.numberOfPages = totalNumberOfPages()

   }
   
   func removePage() {
      
      if contentView.subviews.count > 1 {
         
         let firstSubview = contentView.subviews[0]
         firstSubview.removeFromSuperview()
      } else {
         let alertController = UIAlertController(title: "Can't Delete", message: "Cannot Delete Subview", preferredStyle: .alert)
         let alertAction = UIAlertAction(title: "Can't Delete", style: .cancel, handler: nil)
         alertController.addAction(alertAction)
      }
   }

   
   func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
   }
   
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
      let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
      pageControl.currentPage = Int(pageIndex)
   }
   
}


extension CGFloat {
   static func random() -> CGFloat {
      return CGFloat(arc4random()) / CGFloat(UInt32.max)
   }
}


extension UIColor {
   static func random() -> UIColor {
      return UIColor(red:   .random(),
                     green: .random(),
                     blue:  .random(),
                     alpha: 1.0)
   }
}


extension UIView {
   func currentFirstResponder() -> UIResponder? {
      if self.isFirstResponder {
         return self
      }
      
      for view in self.subviews {
         if let responder = view.currentFirstResponder() {
            return responder
         }
      }
      
      return nil
   }
}






