import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsManager
    @State private var notificationsEnabled = true
    @State private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("General")) {
                    Toggle(isOn: $notificationsEnabled) {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.red)
                            Text("Notifications")
                        }
                    }
                    
                    Toggle(isOn: $settings.soundEnabled) {
                        HStack {
                            Image(systemName: "speaker.wave.2.fill")
                                .foregroundColor(.red)
                            Text("Sound Effects")
                        }
                    }
                    
                    Toggle(isOn: $isDarkMode) {
                        HStack {
                            Image(systemName: "moon.fill")
                                .foregroundColor(.red)
                            Text("Dark Mode")
                        }
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.red)
                        Text("Version 1.0")
                    }
                    
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                            .foregroundColor(.red)
                        Text("Help & Support")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
} 