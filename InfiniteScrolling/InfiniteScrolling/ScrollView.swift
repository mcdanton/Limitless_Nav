//
//  ScrollView.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/21/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class ScrollView: UIViewController, UIGestureRecognizerDelegate {
   
   // MARK: Outlets
   @IBOutlet var superView: UIView!
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var contentView: UIView!
   
   
   // MARK: Properties
   var currentView: UIView!
   var newView: UIView!
   var activeView: UIView!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      currentView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
      currentView.translatesAutoresizingMaskIntoConstraints = false
      currentView.backgroundColor = UIColor.red
      contentView.addSubview(currentView)
      
      newView = UIView(frame: CGRect(x: currentView.frame.origin.x + currentView.frame.width, y: currentView.frame.origin.y, width: currentView.frame.width, height: currentView.frame.height))
      newView.backgroundColor = UIColor.green
      contentView.addSubview(newView)
      
      scrollView.contentSize = CGSize(width: contentView.frame.width * totalNumberOfPages(), height: view.frame.height)
      

   

      let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
      longPress.minimumPressDuration = 0.01
      longPress.delegate = self
      self.view.addGestureRecognizer(longPress)
      
      let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(switchScreens))
      swipeLeft.direction = .left
      swipeLeft.delegate = self
      //self.view.addGestureRecognizer(swipeLeft)
   }
   
   
   func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
      if gestureRecognizer.state == .began  {
      print("press confirmed")
         
      
      
//         UIView.animate(withDuration: 1.0, animations: {
//            self.activeView.frame.size.width *= 0.5
//            self.activeView.frame.size.height *= 0.25
//            self.activeView.frame.origin.x += 75
//            self.activeView.frame.origin.y += 200
//            self.viewSize = self.activeView.frame
//         }, completion: nil)
      
         contentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
         addPage()
         
      } else if gestureRecognizer.state == .ended {
         print("press ended")
         
//         newView?.removeFromSuperview()
     contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
      }
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
   
   func totalNumberOfPages() -> CGFloat {
      var numberOfPages = 0
      for _ in contentView.subviews {
         numberOfPages += 1
      }
      return CGFloat(numberOfPages)
   }
   
   func addPage() {
      
      let newPage = UIView(frame: CGRect(x: view.frame.width * totalNumberOfPages(), y: 0, width: view.frame.width, height: view.frame.height))
      newPage.backgroundColor = UIColor.random()
      contentView.addSubview(newPage)
      scrollView.contentSize = CGSize(width: contentView.frame.width * totalNumberOfPages(), height: view.frame.height)
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






