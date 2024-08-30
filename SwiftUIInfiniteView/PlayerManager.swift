//
//  PlayerManager.swift
//  SwiftUIInfiniteView
//
//  Created by Davidyoon on 8/30/24.
//

import Foundation
import AVKit

class PlayerManager: ObservableObject {
    
    @Published var currentPlayer: AVPlayer?
    
    private var playerCache: [URL: AVPlayer] = [:]
        
        func preloadVideo(for url: URL) {
            if playerCache[url] == nil {
                let player = AVPlayer(url: url)
                player.isMuted = true
                player.play()
                player.pause()
                playerCache[url] = player
            }
        }
        
        func player(for url: URL) -> AVPlayer {
            if let cachedPlayer = playerCache[url] {
                return cachedPlayer
            } else {
                let newPlayer = AVPlayer(url: url)
                playerCache[url] = newPlayer
                return newPlayer
            }
        }
    
}
