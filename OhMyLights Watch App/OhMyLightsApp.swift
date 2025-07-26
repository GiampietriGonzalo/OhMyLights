//
//  OhMyLightsApp.swift
//  OhMyLights Watch App
//
//  Created by Gonza Giampietri on 26/07/2025.
//

import SwiftUI

@main
struct OhMyLights_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            let model = HazardLightsDetectionModel()
            let viewModel = HazardLightsDetectionViewModel(model: model)
            HomeView(viewModel: viewModel)
        }
    }
}
