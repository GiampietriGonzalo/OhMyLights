//
//  SimulatedCMMotionActivity.swift
//  OhMyLights!
//
//  Created by Gonzalo.Giampietri on 12/02/2023.
//

import CoreMotion

class SimulatedCMMotionActivity: CMMotionActivity {
    
    private var _startDate: Date = Date()
    private var _timestamp: TimeInterval = 0.0
    private var _unknown: Bool = true
    private var _stationary: Bool = false
    private var _walking: Bool = false
    private var _running: Bool = false
    private var _automotive: Bool = false
    private var _cycling: Bool = false
    private var _confidence: CMMotionActivityConfidence = .high

    init(startDate: Date, timestamp: TimeInterval, unknown: Bool, stationary: Bool, walking: Bool, running: Bool, automotive: Bool, cycling: Bool, confidence: CMMotionActivityConfidence) {

        super.init()
        self._startDate = startDate
        self._timestamp = timestamp
        self._unknown = unknown
        self._stationary = stationary
        self._walking = walking
        self._running = running
        self._automotive = automotive
        self._cycling = cycling
        self._confidence = confidence
    }

    convenience init(motionActivity: CMMotionActivity, unknown: Bool = true, stationary: Bool = false, walking: Bool = false, running: Bool = false, automotive: Bool = false, cycling: Bool = false) {

        self.init(startDate: motionActivity.startDate, timestamp: 0.0, unknown: unknown, stationary: stationary, walking: walking, running: running, automotive: automotive, cycling: cycling, confidence: motionActivity.confidence)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override open var startDate: Date {
        _startDate
    }

    override open var timestamp: TimeInterval {
        _timestamp
    }

    override open var unknown: Bool {
        _unknown
    }

    override open var stationary: Bool {
        _stationary
    }

    override open var walking: Bool {
        _walking
    }

    override open var running: Bool {
        _running
    }

    override open var automotive: Bool {
        _automotive
    }

    override open var cycling: Bool {
        _cycling
    }

    override open var confidence: CMMotionActivityConfidence {
        _confidence
    }
}
