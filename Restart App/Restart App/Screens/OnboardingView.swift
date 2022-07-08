//
//  OnboardingView.swift
//  Restart App
//
//  Created by Natalie Choo on 7/5/22.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    // we utilize this var to determine the appropriate screen to display

    var body: some View {
        
        ZStack {
            //a Zstack allows us to arrange elements along the Z axis: depth
            //because Zstack refers to depth, there is no spacers, but it can be aligned
            
            Color("ColorBlue").ignoresSafeArea(.all, edges: .all)
            //.ignoreSafeArea allows the blue to fill all the way to edges of device
            // farthest back layer of background color

            VStack(spacing: 20)
            {
                //creating a Vstack allows us to vertically arrange elements
                //there will be a spacing of 20 between the elements within this Vstack
                
                // MARK: HEADER
                
                Spacer()
                // because this spacer is in a Vstack, it will push elements down
                
                
                VStack(spacing: 0) {
                    // This Vstack contains the title text, the body text, and the ZStack containing the image and circles
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    //use .font(.system(size:)) to change size
                    //use fontWeight() for weighting
                    //use foregroundColor() for text color
                    
                    Text("""
It's not how much we give but
how much love we put into giving.
""")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    //just use .font(.type) to choose a preset size
                    //use multilinetextalignment to align multiple lines
                    //use .padding to determine amt of padding on the sides of the text
                } //HEADER
                
                ZStack {
                    //this ZStack will contain a character that lies atop the two circles
                    
                    CircleGroupView(CircleColor: .white, CircleOpacity: 0.2)
                    //using CircleGroupView Method
                    
                    Image("character-1")
                        .resizable()
                        . scaledToFit()
                    //this image is in the outer ZStack, so it is layered atop of the circles
                    
                }// outer Zstack w/ character
                
                Spacer()
                //this Spacer() pushes the ZStack and Vstack text elements up
                
                ZStack {
                    // this ZStack builds the slider bar and the botton atop it
                    
                    // MARK: Static Background
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // MARK: Call to action (static)
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                        
                    
                    // MARK: Dynamic Capsule
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: 80)
                        
                        Spacer()
                        //because this is w/in a Zstack w/ padding but also in an HStack, it will be pushed horizontally as far as the Zstack's padding allows
                    }
                    
                    // MARK: Draggable Circle
                    HStack {
                        //creates another circle of darker opacity with a cheveron image
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .onTapGesture {
                            //when users tap the circle, set this value to false, taking user to the Home screen
                            isOnboardingViewActive = false
                        }
                        
                        Spacer()
                        //Spacer w/in an Hstack moves it over horizontally, as much as the outer ZStack's padding allows
                    }
                    
                }
                .frame(height: 80, alignment: .center)
                .padding()
                //makes all elements in this Zstack at most 80 height and confines it to not go over the device edges
            } //:Vstack
        }//Zstack
    } //Footer
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
