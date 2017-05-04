//
//  UserDefaultsExtension.swift
//  Project 4
//
//  Created by Dan Hefter on 3/24/17.
//  Copyright © 2017 Dan Hefter. All rights reserved.
//

import Foundation

// Extension used to store user roles so user who has previously signed in can be directed past the login process to the appropriate area
extension UserDefaults {
   
   
   func saveAccessToken(value: String) {
      UserDefaults.standard.set(value, forKey: "accessToken")
      UserDefaults.standard.synchronize()
   }
   
   func retrieveAccessToken() -> String {
      let returnedToken = UserDefaults.standard.value(forKey: "accessToken")
      return returnedToken as! String
   }
   
}
