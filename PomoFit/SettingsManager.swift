import Foundation
import AVFoundation

class SettingsManager: ObservableObject {
    @Published var soundEnabled = true
    private var audioPlayer: AVAudioPlayer?
    
    func playCompletionSound() {
        guard soundEnabled else { return }
        AudioServicesPlaySystemSound(1005) // This uses a system sound
    }
} 