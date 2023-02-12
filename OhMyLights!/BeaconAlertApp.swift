//
//  BeaconAlertApp.swift
//  BeaconAlert
//
//  Created by Gonzalo.Giampietri on 08/02/2023.
//

import SwiftUI
import UserNotifications

@main
struct BeaconAlertApp: App {
    var body: some Scene {
        WindowGroup {
            let model = BeaconDetactionModel()
            let viewModel = BeaconDetectionViewModel(model: model)
            ContentView(viewModel: viewModel)
        }
    }
}


private extension BeaconAlertApp {
    
    func startAppConfiguration() {
        askForPusnNotificationPermission()
    }
    
    func askForPusnNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (didAccept, error) in
            guard didAccept else {
                if let error = error { print("Error requesting permission for Push Notifications: \(error.localizedDescription)") }
                return
            }
            
            print("User did accept push notifactions :)")
        }
    }
    
}
