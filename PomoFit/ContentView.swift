//
//  ContentView.swift
//  PomoFit
//
//  Created by Rodrigo Carballo on 10/28/24.
//

import SwiftUI

struct ContentView: View {
   
    @State private var timeRemaining = 25
    @State  var copyOfTimeRemaining : Int
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State private var isTextVisible: Bool = false
    @FocusState private var isTextFieldFocused: Bool


    var body: some View {
        VStack {
                VStack {
                    ZStack {
                        Text("Time to focus")
                            .font(.largeTitle)
                    }
                    

                        if !isTextVisible {
                            TextField("Enter time", text: Binding(
                                        get: { String(timeRemaining) },
                                        set: { newValue in
                                            if let intValue = Int(newValue) {
                                                timeRemaining = intValue
                                                copyOfTimeRemaining = intValue
                                            }
                                        }
                                    ))
                            .font(.largeTitle)
                            .focused($isTextFieldFocused)
                            .multilineTextAlignment(.center) // Centers the text
                            .frame(width: 200, height: 25)
                            .keyboardType(.numberPad) // Opens a numberpad keyboard
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        }
                        
                        
                        if (isTextVisible) {
                            Text(String(copyOfTimeRemaining))
                                .font(.largeTitle)
                                .foregroundColor(Color.red)
                                .multilineTextAlignment(.center) // Centers the text
                                .frame(width: 300, height: 25)
                        }

                    
                    
                }

            if (timeRemaining % 2 == 0) {
                
                Image("Battle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
            }
            
            else {
                Image("Sitting2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
            }
            
            Text("Time Left: \(timeRemaining)")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(.black.opacity(0.75))
                .clipShape(.capsule)
                .padding()
            
            Button(action: {
                // Action for the Reset button
                timeRemaining = 0
                copyOfTimeRemaining = 0
                isTextVisible = false
                    }) {
                        Text("Reset")
                            .font(.headline) // Sets the font size
                            .foregroundColor(.white) // Text color
                            .padding() // Adds padding inside the button
                            .background(Color.red) // Button background color
                            .cornerRadius(10) // Rounds the corners
                            .shadow(radius: 5) // Adds a shadow for depth
                    }
        }
        .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isTextFieldFocused = false // Dismiss keyboard on tap
                        }
                    }
                }
        
        .onReceive(timer) { time in
            guard isActive else {
                return
            }

            if timeRemaining > 0 {
                timeRemaining -= 1
                isTextVisible = true
            }
            else {
                isTextVisible = false
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                isActive = true
            } else {
                isActive = false
            }
        }
        
    }
    
    
}

#Preview {
    ContentView(copyOfTimeRemaining:3)
}
