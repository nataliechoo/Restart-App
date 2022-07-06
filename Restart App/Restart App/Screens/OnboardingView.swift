//
//  OnboardingView.swift
//  Restart App
//
//  Created by Natalie Choo on 7/5/22.
//

import SwiftUI

struct OnboardingView: View {
    // we utilize this var to determine the appropriate screen to display
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        VStack(spacing: 20)
        {
            Text("Onboarding").font(.largeTitle)
            
            Button(action: {
                isOnboardingViewActive = false
            }) {
                Text("Start")
            }
        } //:Vstack
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
