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
import CoreLocation

final class HazardLightsDetectionViewModel: NSObject, ObservableObject {

    //MARK: Published properties
    @Published var userMotionState: UserMotionState = .unknow
    @Published var userActivityState: UserActivityState = .unknow
    
    //MARK: Util properties
    private var model: HazardLightsDetectionModel
    private var wasDriving: Bool = false
    private var isDetectingMotion: Bool = false
    private let motionActivityManager = CMMotionActivityManager()
    private var timer: Timer?
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        
        return locationManager
    }()
    
    init(model: HazardLightsDetectionModel) {
        self.model = model
    }
    
    //With internal modifier for testing
    func handleActivity(_ activity: CMMotionActivity?) {
        guard let activity = activity else { return }
        
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
            self.reproduceAlert()
        } else if activity.unknown || activity.stationary {
            //Not driving, the user was no driving and is quiet
            self.userActivityState = .unknow
            self.userMotionState = .idle
        }
        
        if activity.walking {
            self.userActivityState = .walking
            self.userMotionState = .didEndDriving
            self.reproduceAlert()
        }
        
        if activity.running { self.userActivityState = .running }
    }
    
}

//MARK: CLLocationManagerDelegate
extension HazardLightsDetectionViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Handle new location updates here
    }
}

//MARK: Logic Methods
private extension HazardLightsDetectionViewModel {
    
    func startMotionDetection() {
        startUpdatingLocation()
        isDetectingMotion = true
        userMotionState = .idle
        wasDriving = false
        motionActivityManager.startActivityUpdates(to: .main, withHandler: handleActivity)
    }
    
    func stopMotionDetection() {
        stopUpdatingLocation()
        motionActivityManager.stopActivityUpdates()
        userMotionState = .unknow
        userActivityState = .unknow
        isDetectingMotion = false
        wasDriving = false
    }
    
    func reproduceAlert() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            AudioServicesPlayAlertSound(SystemSoundID(1304))
            if self.userMotionState != .didEndDriving { self.timer?.invalidate() }
        }
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
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
        case .isDriving:
            return model.drivingText
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
        case .isDriving:
            return model.drivingBackGroundColor
        }
    }
    
    func getButtonText() -> String {
        guard isDetectingMotion else {
            if userMotionState == .didEndDriving {
                return model.iGotItText
            } else {
                return model.startMotionText
            }
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
            if userMotionState == .didEndDriving {
                userMotionState = .idle
            } else {
                startMotionDetection()
            }
            
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


