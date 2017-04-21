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
   var menuView: UIView!
   var wasPressed = false
   var viewSize = CGRect()
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      menuView = UIView(frame: CGRect(origin: contentView.frame.origin, size: contentView.frame.size))
      menuView.backgroundColor = UIColor.red
      contentView.addSubview(menuView)
      
      let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
      self.view.addGestureRecognizer(longPress)
   }
   
   
   func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
      print("press confirmed")
      if wasPressed == false {
         
         UIView.animate(withDuration: 1.0, animations: {
            self.menuView.frame.size.width *= 0.5
            self.menuView.frame.size.height *= 0.25
            self.menuView.frame.origin.x += 75
            self.menuView.frame.origin.y += 200
            self.viewSize = self.menuView.frame
            self.wasPressed = true
         }, completion: nil)
         
         var newView = UIView(frame: contentView.frame)
         newView.backgroundColor = .random()
         contentView.addSubview(newView)
      }
   }
   
   
      
      func createNewView(button: UIButton) {
         print("button pressed")
         
         let createdView = UIView(frame: menuView.frame)
         createdView.frame.size.width *= 0.75
         createdView.frame.size.height *= 0.75
         createdView.backgroundColor = UIColor.gray
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



