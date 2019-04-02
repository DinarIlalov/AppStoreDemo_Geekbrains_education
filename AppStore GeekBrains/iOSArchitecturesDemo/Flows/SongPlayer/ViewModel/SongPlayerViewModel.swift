//
//  SongPlayerViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 01/04/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class SongPlayerViewModel {
    weak var viewController: UIViewController?
    
    private let song: ITunesSong
    private let songPlayer: SongPlayer
    
    var songName = Observable<String>("<no name>")
    var songImageUrl = Observable<String>("")
    var songImage = Observable<UIImage>(#imageLiteral(resourceName: "Image"))
    var songDuration = Observable<Double>(0.0)
    var isPlaying = Observable<Bool>(false)
    var songPlayingProgress = Observable<Float>(0.0)
    var songTimeLeftString = Observable<String>("00:00")
    
    init(with song: ITunesSong, songPlayer: SongPlayer) {
        self.song = song
        self.songPlayer = songPlayer
        
        self.songPlayer.onPlaying = { [weak self] currentTimeValue in
            guard let strongSelf = self else { return }
            let songTimeLeft = strongSelf.songDuration.value - currentTimeValue
            strongSelf.songTimeLeftString.value = Date(timeIntervalSince1970: TimeInterval(floatLiteral: songTimeLeft)).toTimeString()
            
            if strongSelf.songDuration.value != 0 {
                strongSelf.songPlayingProgress.value = Float(currentTimeValue*100/strongSelf.songDuration.value)/100
            }
        }
    }
    
    // повесил обзерверы на статические элементы, такие как название песни (могут быть и другие).
    // не знаю надо было ли это делать? или можно было просто заполнить их при инициализации ВьюМодели и просто забрать их значения?
    // как правильно?
    func initiateBunding() {
        self.songName.value = song.trackName
        self.songImageUrl.value = song.artwork ?? ""
        self.songPlayingProgress.value = 0.0
        
        let songDurationSeconds = Double(song.trackTimeMillis ?? 0)/1000
        self.songDuration.value = songDurationSeconds
        self.songTimeLeftString.value = Date(timeIntervalSince1970: TimeInterval(floatLiteral: songDurationSeconds)).toTimeString()
    }
    
    func playPauseButtonDidTap() {
        self.isPlaying.value = !self.isPlaying.value
        
        if self.isPlaying.value {
            songPlayer.start()
        } else {
            songPlayer.pause()
        }
    }
}
