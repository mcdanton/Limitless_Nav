//
//  TestViewController.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/19/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
   
   var allViews = [UIView]()
   var scrollView = UIScrollView()
   var rootView = UIView()
   var wasTapped = false
   
   
   @IBOutlet weak var myView: UIView!
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      scrollView = UIScrollView(frame: self.view.bounds)
      self.view.addSubview(scrollView)
      scrollView.backgroundColor = UIColor.green
      
      rootView = UIView(frame: CGRect(x: 25, y: 200, width: 325, height: 325))
      self.view.addSubview(rootView)
      rootView.backgroundColor = UIColor.red
      
      
      let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
      rootView.addGestureRecognizer(tap)
   }
   
   
   func handleTap(gestureRecognizer: UIGestureRecognizer) {
      print("tap confirmed")
      if wasTapped == false {
         
         UIView.animate(withDuration: 1.0, animations: {
            self.rootView.frame.size.width -= 125
            self.rootView.frame.size.height -= 125
            self.wasTapped = true
         }, completion: nil)
         
         var newView = UIView(frame: CGRect(x: 300, y: 200, width: 200, height: 200))
         newView.backgroundColor = .random()
         scrollView.addSubview(newView)
         allViews.append(newView)
         
         print(allViews)
         
      }
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


