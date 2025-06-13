import Foundation
import UIKit
import AVFoundation
import AudioToolbox
import UserNotifications

class SettingsManager: ObservableObject {
    @Published var soundEnabled = true
    @Published var notificationsEnabled = true
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        requestNotificationPermission()
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                self.notificationsEnabled = granted
            }
            if let error = error {
                print("❌ Notification permission error: \(error)")
            } else {
                print("✅ Notification permission granted: \(granted)")
            }
        }
    }
    
    func scheduleCompletionNotification(for timeInMinutes: Int) {
        guard notificationsEnabled else {
            print("🔔 Notifications disabled, skipping notification schedule")
            return
        }
        
        // Remove any existing notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Focus Session Complete! 🎉"
        content.body = "Great job! You've completed your \(timeInMinutes)-minute focus session. Time for a break!"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInMinutes * 60), repeats: false)
        let request = UNNotificationRequest(identifier: "pomofit-completion", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Failed to schedule notification: \(error)")
            } else {
                print("✅ Notification scheduled for \(timeInMinutes) minutes")
            }
        }
    }
    
    func cancelScheduledNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("🔔 Cancelled all scheduled notifications")
    }
    
    func playCompletionSound() {
        print("🔊 playCompletionSound() called")
        print("🔊 soundEnabled is: \(soundEnabled)")
        
        guard soundEnabled else { 
            print("🔊 Sound is disabled, returning early")
            return 
        }
        
        print("🔊 Playing completion sound and haptic feedback")
        
        // Option 1: Use a reliable system sound
        AudioServicesPlaySystemSound(SystemSoundID(1016)) // This is a nice completion sound
        
        // Option 2: Add haptic feedback for better user experience
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback.impactOccurred()
        
        print("🔊 Sound and haptic feedback completed")
    }
} 
