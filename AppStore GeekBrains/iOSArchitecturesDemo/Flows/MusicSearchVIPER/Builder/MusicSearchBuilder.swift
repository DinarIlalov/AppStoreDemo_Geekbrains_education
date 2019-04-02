//
//  MusicSearchBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 02/04/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class MusicSearchBuilder {
    static func build() -> UIViewController {
        let router = MusicSearchRouter()
        let searchService = ITunesSearchService()
        let interactor = MusicSearchInteractor(searchService: searchService)
        let presenter = MusicSearchPresenter(interactor: interactor, router: router)
        let viewController = MusicSearchViewController(presenter: presenter)
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
