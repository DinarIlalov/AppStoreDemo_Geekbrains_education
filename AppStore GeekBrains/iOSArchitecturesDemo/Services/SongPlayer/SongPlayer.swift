//
//  SongPlayer.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 02/04/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import Foundation

final class SongPlayer {
    
    typealias SongPlayerTimeValue = Double
    
    private let song: ITunesSong
    private let songDuration: Double
    
    private weak var timer: Timer?
    
    var currentTime: Double = 0.0
    
    var onPlaying: ((SongPlayerTimeValue) -> Void)?
    
    init(song: ITunesSong) {
        self.song = song
        self.songDuration = Double(song.trackTimeMillis ?? 0)/1000
    }
    
    func start() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            if self.currentTime > self.songDuration-0.99 {
                self.currentTime = self.songDuration
                self.onPlaying?(self.currentTime)
                self.pause()
                return
            }
            self.currentTime += 1
            self.onPlaying?(self.currentTime)
        }
        
    }
    
    func pause() {
        timer?.invalidate()
        timer = nil
    }
}
