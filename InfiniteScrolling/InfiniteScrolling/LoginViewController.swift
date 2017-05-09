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
      
      // Login function sends user info to server and server returns token. Token is saved to User Defaults to allow easy authentication later. Upon successful login, user is taken to the User Homepage.
      login(path: RESTPath.login.rawValue , usernameTF.text!, emailTF.text!, passwordTF.text!, closure: { token in
         parseAccessToken(data: token, closure: { [weak self] accessToken in
            guard let unwrappedSelf = self else {return}
            print("token is \(accessToken)")
            UserDefaults.standard.set(accessToken, forKey: "accessToken")
            UserDefaults.standard.synchronize()
            
            DispatchQueue.main.async {
               unwrappedSelf.performSegue(withIdentifier: "loginSuccess", sender: self)
            }
         })
      })
      
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}
