//
//  SongPlayerBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 01/04/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class SongPlayerBuilder {
    static func build(with song: ITunesSong) -> UIViewController {
        let songPlayer = SongPlayer(song: song)
        let viewModel = SongPlayerViewModel(with: song, songPlayer: songPlayer)
        let viewController = SongPlayerViewController(viewModel: viewModel)
        
        viewModel.viewController = viewController
        
        return viewController
    }
}
