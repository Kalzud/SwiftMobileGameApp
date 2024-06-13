//
//  GameDataManager.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//  This class controls the all game data for this application needed across various views
//  it handles teh background, sound, and essetila player data it also
//  operates as a singleton (only a single instance of it is used through out the game)

//...........Import Statements...............................
import UIKit
import AVFAudio


class GameDataManager {
    static let shared = GameDataManager()
    var currentPlayerName: String = "" // Default player name
    var currentPlayerScore: Int = 0 // Default player score
    var backgroundColor: UIColor = .white  // Default background color
    
    //.............. Sound controls and fields............................................
    var backgroundAudioPlayer: AVAudioPlayer?
    var gameBackgroundAudioPlayer: AVAudioPlayer?
    var interactionAudioPlayer: AVAudioPlayer?
    var scoreAudioPlayer: AVAudioPlayer?
    var isSoundOn: Bool = true
    var soundTimer: Timer?

    // MARK: -GAME SETUP AND MUTATORS
    
    //==============================================================
    // Method to update background color
    func updateBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    //==============================================================
    // Method to set current player name
    func setUpCurrentPlayerName(currentName: String){
        currentPlayerName = currentName
    }
    
    //=============================================================================
    //setting up the background music/audio
    func setupBackgroundAudio(filename: String, volume: Float){
        stopSound()
        // Load audio file
        if let soundURL = Bundle.main.url(forResource: filename, withExtension: "wav") {
            do {
                // Create audio player
                backgroundAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                
                // Configure audio player for looping
                backgroundAudioPlayer?.numberOfLoops = -1  // Infinite loop
                
                // Set audio volume
                backgroundAudioPlayer?.volume = volume
                
                // Prepare to play audio
                backgroundAudioPlayer?.prepareToPlay()
            } catch {
                print("Error loading sound file: \(error.localizedDescription)") // Print error notification if sound can't load
            }
        } else {
            print("Audio file not found.") // Print error notification if audio is not found
        }
        playSound() // play the sound
    }
    
    //============================================================================
    //playing the background music
    func playSound() {
        // Check if audio player is initialized and audio file is loaded
        if let player = backgroundAudioPlayer {
            player.play() // play the audio
        } else {
            print("Audio player is not ready.") // print error message is audio isnt reday
        }
        isSoundOn = true // toggle soundOn to true
    }
    
    //============================================================================
    //stop background music
    func stopSound(){
        // Check if audio player is initialized and audio file is loaded
        if let player = backgroundAudioPlayer {
            player.stop() // stop the audio
        } else {
            print("Audio player is not ready.") // print error message is audio isnt reday
        }
        isSoundOn = false // toggle soundOn to false
    }

    //=============================================================================
    //setting up the game interaction sounds
    func playGameInteractionSound(filename: String, timer: Double) {
        // check if the soundOn is true
        if (isSoundOn == true){
            
            stopInteractionSound() // Stop previously playing sound
            
            // Load audio file
            if let soundURL = Bundle.main.url(forResource: filename, withExtension: "wav") {
                do {
                    // Create audio player
                    interactionAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    
                    // Configure audio player for non-looping playback
                    interactionAudioPlayer?.numberOfLoops = 0  // No looping
                    
                    // Prepare to play audio
                    interactionAudioPlayer?.prepareToPlay()
                    
                    // Start playing audio
                    interactionAudioPlayer?.play()
                    
                    // Schedule a timer to stop the audio after 3 seconds
                    soundTimer = Timer.scheduledTimer(withTimeInterval: timer, repeats: false) { [weak self] _ in
                        self?.stopInteractionSound()
                    }
                } catch {
                    print("Error loading sound file: \(error.localizedDescription)") // Print error notification if sound can't load
                }
            } else {
                print("Audio file not found.") // Print error notification if sound can't be found
            }
        }
    }
    //=============================================================================
    // Stop interaction sound
    func stopInteractionSound() {
        // Check if audio player is initialized and currently playing
        if let player = interactionAudioPlayer, player.isPlaying {
            player.stop() // stop the player
            soundTimer?.invalidate()  // Invalidate the timer
        }
    }
//............................................................END OF CLASS..........................................................................
}
