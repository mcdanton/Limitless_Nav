//
//  UserPageViewController.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 5/4/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class UserPageViewController: UIViewController {

   
   @IBAction func authPressed(_ sender: Any) {
      
      let accessToken = UserDefaults.standard.object(forKey: "accessToken") as? String ?? "No Token Returned"
      
      authUser(path: RESTPath.auth.rawValue, token: accessToken, closure: { [weak self] success in
         guard let unwrappedSelf = self else {return}
         
         print("user is authorized")
         
      })
      
      
   }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()


   
   }


   
   
}
