//
//  BeaconDetectionModel.swift
//  BeaconAlert
//
//  Created by Gonzalo.Giampietri on 08/02/2023.
//

import SwiftUI

final class HazardLightsDetectionModel: ObservableObject {
    let idleBackGroundColor = Color("DarkGreyPastel")
    let drivingBackGroundColor = Color("GreenPastel")
    let didStopDrivingBackgroundColor = Color("OrangePastel")
    let didEndDrivingBackgroundColor = Color("RedPastel")
    
    let idleText = "Don't worry 😎"
    let drivingText = "Driving 🚗"
    let didStopText = "Driving and Stop 🛑"
    let didEndDrivingText = "⚠️CHECK LIGHTS!!!⚠️"
    
    let startMotionText = "Start Motion Detection"
    let stopMotionText = "Stop Motion Detection"
    
    let buttonStartMotionImage = "figure.walk.motion"
    let buttonStopMotionImage = "stop.circle.fill"
    
//    let buttonStartMotionColor = "DarkGreyPastel"
//    let buttonStopMotionColor = "DarkGreyPastel"
}
