//
//  DigitalClockView.swift
//  OhMyLights!
//
//  Created by Gonzalo.Giampietri on 12/02/2023.
//

import SwiftUI

struct DigitalClockView: View {
    @StateObject var viewModel: DigitalClockViewModel = DigitalClockViewModel()
    
    var body: some View {
        Text(viewModel.timeString)
            .font(.system(size: 100, weight: .medium))
            .foregroundColor(.white)
    }
    
}

struct DigitalClock_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            DigitalClockView()
        }
    }
}
