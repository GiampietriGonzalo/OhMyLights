//
//  AppDelegate.swift
//  OhMyLights!
//
//  Created by Gonzalo.Giampietri on 10/02/2023.
//

import Foundation
import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //startAppConfiguration()
        return true
    }
}

private extension AppDelegate {
    
    func startAppConfiguration() {
        askForPusnNotificationPermission()
    }
    
    func askForPusnNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (didAccept, error) in
            guard didAccept else {
                if let error = error { print("Error requesting permission for Push Notifications: \(error.localizedDescription)") }
                return
            }
            
            DispatchQueue.main.async {
              UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
}
