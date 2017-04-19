//
//  TestViewController.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/19/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UIGestureRecognizerDelegate {

   var dansView = UIView()
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
      dansView = UIView(frame: self.view.bounds)
      self.view.addSubview(dansView)


      let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
      gestureRecognizer.delegate = self
      dansView.addGestureRecognizer(gestureRecognizer)
    }


   func handleTap(gestureRecognizer: UIGestureRecognizer) {
      let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
      alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
   }
   
   

}
