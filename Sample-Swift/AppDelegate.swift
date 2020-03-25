//
//  AppDelegate.swift
//  Sample-Swift
//
//  Created by Brian Boyle on 20/07/2016.
//  Copyright © 2016 Intercom. All rights reserved.
//

import UIKit
import Intercom

let INTERCOM_APP_ID = "fk8lvknh"
let INTERCOM_API_KEY = "ios_sdk-fac1cbdb78d5aa69b86dfe5c21c1a902b8f3e192"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Intercom.setApiKey("ios_sdk-fac1cbdb78d5aa69b86dfe5c21c1a902b8f3e192", forAppId:"fk8lvknh")
        Intercom.setLauncherVisible(false)
        
        #if DEBUG
            Intercom.enableLogging()
        #endif
    
        let defaults = UserDefaults.standard
        if let email = defaults.string(forKey: emailKey) {
            Intercom.registerUser(withEmail: email)
        }
//        3 options of user registration
//        Intercom.registerUnidentifiedUser()
//        Intercom.registerUser(withUserId: String)
//        Intercom.registerUser(withUserId: <#T##String#>, email: <#T##String#>)
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Intercom.setDeviceToken(deviceToken)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if (Intercom.isIntercomPushNotification(userInfo)) {
            Intercom.handlePushNotification(userInfo)
        }
        completionHandler(.noData);
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //Register for push notifications
        //For more info, see: https://developers.intercom.com/installing-intercom/docs/ios-push-notifications
        let center = UNUserNotificationCenter.current()
        // Request permission to display alerts and play sounds.
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        UIApplication.shared.registerForRemoteNotifications()
    }

}

