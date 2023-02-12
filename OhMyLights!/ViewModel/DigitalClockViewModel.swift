//
//  DigitalClockViewModel.swift
//  OhMyLights!
//
//  Created by Gonzalo.Giampietri on 12/02/2023.
//

import SwiftUI

final class DigitalClockViewModel: ObservableObject {
    
    @Published var timeString: String = "00:00"
    
    init() {
        startDigitalTime()
    }
    
    private func startDigitalTime() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (_) in
            guard let self = self else { return }
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            let currentTime = dateFormatter.string(from: date)
            self.timeString = currentTime
        }
    }
}
