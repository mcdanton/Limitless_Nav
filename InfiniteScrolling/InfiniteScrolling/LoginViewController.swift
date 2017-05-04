//
//  LoginViewController.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 5/3/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
   
   
   // Outlets
   @IBOutlet weak var usernameTF: UITextField!
   @IBOutlet weak var emailTF: UITextField!
   @IBOutlet weak var passwordTF: UITextField!
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   
   
   @IBAction func loginPressed(_ sender: Any) {
      
      login(path: RESTPath.login.rawValue , usernameTF.text!, emailTF.text!, passwordTF.text!, closure: { token in
         parseAccessToken(data: token, closure: { accessToken in
            print("token is \(accessToken)")
            UserDefaults.standard.set(accessToken, forKey: "accessToken")
            UserDefaults.standard.synchronize()
            authUser(path: RESTPath.auth.rawValue, token: accessToken, closure: { [weak self] success in
               guard let unwrappedSelf = self else {return}
               DispatchQueue.main.async {
                  unwrappedSelf.performSegue(withIdentifier: "loginSuccess", sender: self)
               }
            })
         })
      })
      
   }
   
   
   
   
   
      
   
      
   
   
   
   
   
   
   
   
}
