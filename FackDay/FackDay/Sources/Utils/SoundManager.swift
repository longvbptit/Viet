//
//  SoundManager.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

struct SoundInfo: Decodable {
    let name: String
    let filename: String
    let duration: TimeInterval
}

class SoundManager: NSObject, AVAudioPlayerDelegate {
    static let shared = SoundManager()
    
    var sounds: [SoundInfo]!
    var players: [URL: AVAudioPlayer] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []

    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "SoundData", withExtension: "plist") else { return}
        
        do {
            let data = try? Data(contentsOf: url)
            let decode = PropertyListDecoder()
            self.sounds  = try decode.decode([SoundInfo].self, from: data!)
            
            print("load data success")
        }
        catch {
            print("cannot read character data")
        }
    }
    
    func getCurrentProgress() -> TimeInterval {
        guard let player = players.first else {
            return -1
        }
        return player.value.currentTime
    }
    
    func stopSound() {
        
        for item in players {
            item.value.stop()
        }
        
        players.removeAll()
        duplicatePlayers.removeAll()
        
    }
    
    func playsound(_ sound: String) {
        
        if let instURL = Bundle.main.url(forResource: "Inst_\(sound)", withExtension: "mp3") {
            self.playSound(soundURL: instURL)
        }
        
        if let voicesURL = Bundle.main.url(forResource: "Voices_\(sound)", withExtension: "mp3") {
            self.playSound(soundURL: voicesURL)
        }
    }
    
    
    private func playSound (soundURL: URL){
        if let player = players[soundURL] { //player for sound has been found

            if !player.isPlaying { //player is not in use, so use that one
                player.prepareToPlay()
                player.play()
            } else { // player is in use, create a new, duplicate, player and use that instead

                do {
                    let duplicatePlayer = try AVAudioPlayer(contentsOf: soundURL)

                    duplicatePlayer.delegate = self
                    duplicatePlayers.append(duplicatePlayer)

                    duplicatePlayer.prepareToPlay()
                    duplicatePlayer.play()
                } catch let error {
                    print(error.localizedDescription)
                }

            }
        } else { //player has not been found, create a new player with the URL if possible
            do {
                let player = try AVAudioPlayer(contentsOf: soundURL)
                players[soundURL] = player
                player.prepareToPlay()
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.stopSound()
    }
}
