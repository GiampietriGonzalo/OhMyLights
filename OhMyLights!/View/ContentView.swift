//
//  ContentView.swift
//  BeaconAlert
//
//  Created by Gonzalo.Giampietri on 08/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: HazardLightsDetectionViewModel
    
    var body: some View {
        ZStack {
            BackgroundView(viewModel: viewModel)
            
            VStack {
                Spacer()
                DigitalClockView()
                Spacer()
                
                Text(viewModel.getText())
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                MotionButton(viewModel: viewModel)
                Spacer(minLength: 315)
                Label("Status: " + viewModel.userActivityState.rawValue,
                      systemImage: viewModel.getCurrentStatusImage())
                .foregroundColor(.white)
                .font(.title2)
            }
        }
    }
}

struct BackgroundView: View {
    @StateObject var viewModel: HazardLightsDetectionViewModel
    
    var body: some View {
        viewModel.getBackgroundColor()
            .edgesIgnoringSafeArea(.all)
    }
}

fileprivate struct MotionButton: View {
    @StateObject var viewModel: HazardLightsDetectionViewModel
    
    var body: some View {
        Button(action: {
            viewModel.didPressButton()
        }, label: {
            Label(viewModel.getButtonText(),
                  systemImage: viewModel.getColorImageName())
        })
        .buttonStyle(.bordered)
        .foregroundColor(Color("DarkGreyPastel"))
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = HazardLightsDetectionModel()
        let viewModel = HazardLightsDetectionViewModel(model: model)
        ContentView(viewModel: viewModel)
    }
}
