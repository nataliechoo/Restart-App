//
//  CircleGroupView.swift
//  Restart App
//
//  Created by Natalie Choo on 7/8/22.
//

import SwiftUI

struct CircleGroupView: View {
    
    @State var CircleColor:  Color
    @State var CircleOpacity: Double
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            //this ZStack will contain two circles, the second circle will be layered atop the second.
            //these circles exist below the above ZStack layer
            Circle()
                .stroke(CircleColor.opacity(CircleOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(CircleColor.opacity(CircleOpacity), lineWidth: 80)
                .frame(width: 260, height:260, alignment: .center)
            //these two circles are aligned with each other but one is thicker
            
        }// inner Zstack w/ circles
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1:0)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
        
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            CircleGroupView(CircleColor: .white, CircleOpacity: 0.2)
        }
    }
}
