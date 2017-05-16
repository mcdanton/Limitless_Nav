//
//  AppDelegate.swift
//  InfiniteScrolling
//
//  Created by Dan Hefter on 4/6/17.
//  Copyright © 2017 DH. All rights reserved.
//

import UIKit
import Analytics


class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?
   var currentUnityController: UnityAppController!



   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
      
      let analyticsConfig = SEGAnalyticsConfiguration(writeKey: "9QE1ES9qKKqBS3DZfCJ2DqEyqSmRBQr5")
      
      print("Analytics config: \(analyticsConfig.debugDescription)")

      
      analyticsConfig!.trackApplicationLifecycleEvents = true
      analyticsConfig!.recordScreenViews = true
      
      SEGAnalytics.setup(with: analyticsConfig)
      
    //  let analytics = SEGAnalytics(configuration: analyticsConfig)
      
      SEGAnalytics.shared().track(("swift sucks"))
      
//      print("Third SHARED analytics config: \(sharedAnalytics.debugDescription)")
//      print(sharedAnalytics.debugDescription)
      
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

