//
//  ScrollView.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/21/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class ScrollView: UIViewController {
   
   // MARK: Outlets
   @IBOutlet var superView: UIView!
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var contentView: UIView!
   
   
   // MARK: Properties
   var currentView: UIView!
   var wasPressed = false
   var viewSize = CGRect()
   var newView: UIView?
   var activeView: UIView!
   
   
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      
   
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      currentView = UIView(frame: CGRect(origin: contentView.frame.origin, size: contentView.frame.size))
      currentView.backgroundColor = UIColor.red
      contentView.addSubview(currentView)
      
      let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
      imageView.image = UIImage(named: "github-logo-in-a-rounded-square_318-40761")
      currentView.addSubview(imageView)
      
      let widthConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: contentView.frame.width)
      let heightConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: contentView.frame.height)
      let horizontalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
      let verticalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
      
      view.addConstraints([widthConstraint, horizontalConstraint, verticalConstraint, heightConstraint])
      


      let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
      self.view.addGestureRecognizer(longPress)
      
      let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(switchScreens))
      self.view.addGestureRecognizer(swipeRight)
   }
   
   
   func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
      if gestureRecognizer.state == .began {
      print("press confirmed")
      
      
//         UIView.animate(withDuration: 1.0, animations: {
//            self.activeView.frame.size.width *= 0.5
//            self.activeView.frame.size.height *= 0.25
//            self.activeView.frame.origin.x += 75
//            self.activeView.frame.origin.y += 200
//            self.viewSize = self.activeView.frame
//            self.wasPressed = true
//         }, completion: nil)
      
      
      self.currentView.frame.size.width = 150
      self.currentView.frame.size.height = 150
      self.currentView.frame.origin.x = 150
      self.currentView.frame.origin.y = 150

         newView = UIView(frame: CGRect(x: 300, y: 200, width: 200, height: 200))
         newView?.backgroundColor = UIColor.green
         contentView.addSubview(newView!)
      } else if gestureRecognizer.state == .ended {
         print("Press Ended")
      }
   }
   
   
   func switchScreens(gestureRecognizer: UISwipeGestureRecognizer) {
      print("Swipe recognized")
      
      UIView.animate(withDuration: 1.0, animations: {
         self.newView?.frame = self.view.frame
         self.activeView = self.newView
         self.wasPressed = false
      }, completion: nil)
      
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

