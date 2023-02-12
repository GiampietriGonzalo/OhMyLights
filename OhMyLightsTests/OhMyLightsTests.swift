//
//  OhMyLightsTests.swift
//  OhMyLightsTests
//
//  Created by Gonzalo.Giampietri on 12/02/2023.
//

import XCTest
@testable import OhMyLights_
import CoreMotion

final class OhMyLightsTests: XCTestCase {
    
    var motionActivitySample: [CMMotionActivity] = []
    var sut: HazardLightsDetectionViewModel!
    
    override func setUp() {
        sut = HazardLightsDetectionViewModel(model: HazardLightsDetectionModel())
    }
    
    override func tearDown() {
        sut = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let stationaryActivity = SimulatedCMMotionActivity(motionActivity: CMMotionActivity(), stationary: true)
        let walkingActivity = SimulatedCMMotionActivity(motionActivity: CMMotionActivity(), walking: true)
        let drivingActivity = SimulatedCMMotionActivity(motionActivity: CMMotionActivity(), automotive: true)
        let drivingStopActivity = SimulatedCMMotionActivity(motionActivity: CMMotionActivity(), stationary: true, automotive: true)
        let drivingEndActivity = SimulatedCMMotionActivity(motionActivity: CMMotionActivity())

        motionActivitySample = [stationaryActivity,  walkingActivity, drivingActivity, drivingStopActivity, drivingEndActivity]

        motionActivitySample.forEach({
            sut.handleActivity($0)
        })
        
        XCTAssert(sut.userMotionState == .didEndDriving)
    }
        
        func testPerformanceExample() throws {
            // This is an example of a performance test case.
            measure {
                // Put the code you want to measure the time of here.
        }
    }

}
