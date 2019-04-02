//
//  AppStartConfigurator.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppStartManager {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        
        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        
        // apps search
        let searchVC = SearchModuleBuilder.build()
        searchVC.navigationItem.title = "Search via iTunes"
        
        let navSearchVC = self.configuredNavigationController()
        navSearchVC.viewControllers = [searchVC]
        navSearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        // song search
        let songsSearchVC = SongsSearchBuilder.build()
        songsSearchVC.navigationItem.title = "Songs via iTunes"
        
        let navSongsSearchVC = self.configuredNavigationController()
        navSongsSearchVC.viewControllers = [songsSearchVC]
        navSongsSearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        // music search
        let musicSearchVC = MusicSearchBuilder.build()
        musicSearchVC.navigationItem.title = "Music via iTunes"
        
        let navMusicSearchVC = self.configuredNavigationController()
        navMusicSearchVC.viewControllers = [musicSearchVC]
        navMusicSearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        tabBarController.viewControllers = [navSearchVC, navSongsSearchVC, navMusicSearchVC]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    private func configuredNavigationController() -> UINavigationController {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }
}
