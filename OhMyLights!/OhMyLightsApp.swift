//
//  OhMyLights_App.swift
//  OhMyLights!
//
//  Created by Gonzalo.Giampietri on 10/02/2023.
//

import SwiftUI

@main
struct OhMyLightsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let model = HazardLightsDetectionModel()
            let viewModel = HazardLightsDetectionViewModel(model: model)
            ContentView(viewModel: viewModel)
        }
    }
}


