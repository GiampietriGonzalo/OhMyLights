//
//  HazardLightsDetectionViewModel.swift
//  BeaconAlert
//
//  Created by Gonzalo.Giampietri on 08/02/2023.
//

import SwiftUI
import Combine
import CoreMotion
import AudioToolbox

final class HazardLightsDetectionViewModel: ObservableObject {

    @Published var model: HazardLightsDetectionModel
    @Published var userMotionState: UserMotionState = .unknow
    @Published var userActivityState: UserActivityState = .unknow
    private var wasDriving: Bool = false
    private var isDetectingMotion: Bool = false
    private let motionActivityManager = CMMotionActivityManager()
    
    init(model: HazardLightsDetectionModel) {
        self.model = model
    }
    
    //With internal modifier for testing
    func handleActivity(_ activity: CMMotionActivity) {
        self.isDetectingMotion = true
        
        if !self.wasDriving && activity.automotive {
            self.wasDriving = true
        }
        
        if activity.automotive {
            // Driving
            self.userActivityState = .driving
            if activity.stationary {
                // Driving but stop somewhere
                self.userMotionState = .didStopDriving
            }
        } else if self.wasDriving {
            //MARK: Not driving, the user was driving and now is quiet -> ALERT ABOUT HAZARD LIGHTS
            self.stopMotionDetection()
            self.userMotionState = .didEndDriving
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        } else if activity.unknown || activity.stationary {
            //Not driving, the user was no driving and is quiet
            self.userActivityState = .unknow
            self.userMotionState = .idle
        }
        
        if activity.walking { self.userActivityState = .walking }
        
        if activity.running { self.userActivityState = .running }
    }

}

//MARK: Logic Methods
private extension HazardLightsDetectionViewModel {
    
    func startMotionDetection() {
        isDetectingMotion = true
        userMotionState = .idle
        motionActivityManager.startActivityUpdates(to: .main, withHandler: { [weak self] activity in
            guard let self = self, let activity = activity else { return }
            self.handleActivity(activity)
        })
    }
    
    func stopMotionDetection() {
        motionActivityManager.stopActivityUpdates()
        userMotionState = .unknow
        userActivityState = .unknow
        isDetectingMotion = false
        self.wasDriving = false
    }
    
}

//MARK: UI Customization Methods
extension HazardLightsDetectionViewModel {
    
    func getText() -> String {
        switch userMotionState {
        case .idle, .unknow:
            return model.idleText
        case .didEndDriving:
            return model.didEndDrivingText
        case .didStopDriving:
            return model.didStopText
        }
    }
    
    func getBackgroundColor() -> Color {
        switch userMotionState {
        case .idle, .unknow:
            return model.idleBackGroundColor
        case .didEndDriving:
            return model.didEndDrivingBackgroundColor
        case .didStopDriving:
            return model.didStopDrivingBackgroundColor
        }
    }
    
    func getButtonText() -> String {
        guard isDetectingMotion else {
            return model.startMotionText
        }
        
        return model.stopMotionText
    }
    
    func getColorImageName() -> String {
        guard isDetectingMotion else {
            return model.buttonStartMotionImage
        }
        
        return model.buttonStopMotionImage
    }
    
    func didPressButton() {
        guard isDetectingMotion else {
            startMotionDetection()
            return
        }
    
        stopMotionDetection()
    }
    
    func getCurrentStatusImage() -> String {
        switch userActivityState {
        case .walking:
            return "figure.walk.circle.fill"
        case .driving:
            return "car.circle.fill"
        case .unknow:
            return "figure.stand"
        case .running:
            return "figure.run.circle.fill"
        }
    }
}


