//
//  MusicSearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 02/04/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class MusicSearchRouter {
    
    weak var viewController: UIViewController?
    
    func openPlayer(for song: ITunesSong) {
        let songPlayerViewController = SongPlayerBuilder.build(with: song)
        self.viewController?.navigationController?.pushViewController(songPlayerViewController, animated: true)
    }
    
}
