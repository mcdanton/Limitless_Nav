//
//  AppDelegate.swift
//  ToImportUnity
//
//  Created by Dan Hefter on 4/28/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
   
   var window: UIWindow?
   var currentUnityController: UnityAppController!
   
   
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
   
      
      return true
   }
   
   func applicationWillResignActive(_ application: UIApplication) {
      currentUnityController.applicationWillResignActive(application)
   }
   
   func applicationDidEnterBackground(_ application: UIApplication) {
      currentUnityController.applicationDidEnterBackground(application)
   }
   
   func applicationWillEnterForeground(_ application: UIApplication) {
      currentUnityController.applicationWillEnterForeground(application)
   }
   
   func applicationDidBecomeActive(_ application: UIApplication) {
      currentUnityController.applicationDidBecomeActive(application)
   }
   
   func applicationWillTerminate(_ application: UIApplication) {
      currentUnityController.applicationWillTerminate(application)
   }
   
   
}

