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
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 37
    // allows us to have the proper screen width for any device, which makes our button adaptable
    
    @State private var buttonOffset: CGFloat = 0
    // initialize buttonOffset to 0, since it will not be moved at compile time
    
    @State private var isAnimating: Bool = false
    
    @State private var imageOffset: CGSize = .zero
    
    @State private var indicatorOpacity: Double = 1.0
    
    @State private var textTitle: String = "Share."
    
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
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
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
                .opacity(isAnimating ? 1 : 0)   //transition from invis to visible
                .offset(y: isAnimating ? 0 : -40)   // move into place when animating
                .animation(.easeOut(duration:1), value: isAnimating)
                //animate for 1 sec based on isAnimating var
                
                ZStack {
                    //this ZStack will contain a character that lies atop the two circles
                    
                    CircleGroupView(CircleColor: .white, CircleOpacity: 0.2)
                        .offset(x: imageOffset.width * -1) //move in opp direction of char
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration:1), value: imageOffset)
                    //using CircleGroupView Method
                    
                    Image("character-1")
                        .resizable()
                        . scaledToFit()
                        .opacity(isAnimating ? 1: 0) //appear upon animation
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    //allow drag movement within bounds
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    //snap character back to center
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                }
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    //ease in upon animation
                    //this image is in the outer ZStack, so it is layered atop of the circles
                    
                }// outer Zstack w/ character
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                        , alignment: .bottom
                )
                
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
                            .frame(width: buttonOffset + 80)
                        //this allows the capsule to deform size according to the buttonOffset, +80 because the offset will initially be 0, and we want the capsule to initially be a circle
                        
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
                        .offset(x: buttonOffset)    //move the object with buttonOffset
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80
                                    {
                                        //when the gesture translation width changes, adjust the buttonOffset as well, so long as the buttonOffset stays within the background bounds
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    //when the gesture is done, if the offset is over half of the width, we change screens and move the offset to the end
                                    //if the offset is less than half the width at the end of the mvoement, we move it back to 0 and dont change screens
                                    withAnimation(Animation.easeOut(duration:0.4)) {
                                        if buttonOffset > buttonWidth/2 {
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        }
                                        else {
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )
                        
                        Spacer()
                        //Spacer w/in an Hstack moves it over horizontally, as much as the outer ZStack's padding allows
                    }
                    
                }
                .frame(height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration:1), value: isAnimating)
                //makes all elements in this Zstack at most 80 height and confines it to not go over the device edges
            } //:VSTACK
        }//ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    } //Footer
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
