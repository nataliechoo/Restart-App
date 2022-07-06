//
//  ContentView.swift
//  Restart App
//
//  Created by Natalie Choo on 7/4/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View
    {
        ZStack {
            if isOnboardingViewActive
            {
                OnboardingView()
            }
            else
            {
                homeView()
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
