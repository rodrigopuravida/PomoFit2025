//
//  ContentView.swift
//  PomoFit
//
//  Created by Rodrigo Carballo on 10/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 0
    @State private var totalTime = 0
    @State private var timer: Timer?
    @State private var isRunning = false
    @State private var timeInput: String = ""
    @State var randomNumber = Int.random(in: 1...3)
    @State private var isTextFieldDisabled = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Time to focus")
                    .font(.largeTitle)
                Text("Enter your time in minutes below")
                    .font(.subheadline)
                
                TextField("Minutes", text: $timeInput)
                    .font(.title)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(isTextFieldDisabled)
                    .frame(width: 200)
                    .padding()
                    .multilineTextAlignment(.center)
            }
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(timeRemaining) / CGFloat(totalTime))
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.red)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.linear, value: timeRemaining)
                
                Text("\(timeRemaining/60)")
                    .font(.title)
                    .foregroundColor(.red)
            }
            .frame(width: 100, height: 100)
            
            if (randomNumber == 1) {
                Image("Battle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
            } else if (randomNumber == 2) {
                Image("Sitting2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
            } else {
                Image("Tarz")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
            }
            
            HStack {
                Button(action: startTimer) {
                    Text("Start")
                }
                .disabled(isRunning)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                /*
                Button(action: stopTimer) {
                    Text("Stop")
                }
                .disabled(!isRunning)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .shadow(radius: 5)
                 */
                
                Button(action: resetTimer) {
                    Text("Reset")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
    }
    
    func startTimer() {
        guard let minutes = Int(timeInput), minutes > 0 else { return }
        isRunning = true
        totalTime = minutes * 60
        timeRemaining = totalTime
        isTextFieldDisabled.toggle()
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 60
                randomNumber = Int.random(in: 1...3)
            } else {
                stopTimer()
            }
        }
    }
    
    
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
     
    
    func resetTimer() {
        stopTimer()
        timeRemaining = 0
        totalTime = 0
        timeInput = ""
    }
}

#Preview {
    ContentView()
}
