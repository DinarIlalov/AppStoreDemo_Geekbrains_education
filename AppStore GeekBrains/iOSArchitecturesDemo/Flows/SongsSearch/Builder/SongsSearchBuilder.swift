//
//  SongsSearchBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 29/03/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class SongsSearchBuilder {
    static func build() -> UIViewController {
        let songsSearchModel = SongsSearchModel()
        let songsSearchPresenter = SongsSearchPresenter(model: songsSearchModel)
        let songsSearchViewController = SongsSearchViewController(presenter: songsSearchPresenter)
        songsSearchPresenter.viewController = songsSearchViewController
        
        return songsSearchViewController
    }
}
