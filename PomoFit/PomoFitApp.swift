//
//  PomoFitApp.swift
//  PomoFit
//
//  Created by Rodrigo Carballo on 10/28/24.
//

import SwiftUI

@main
struct PomoFitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(timeRemaining: 0, copyOfTimeRemaining: 0)
        }
    }
}
