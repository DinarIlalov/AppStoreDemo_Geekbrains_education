//
//  MusicSearchViewInput.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 02/04/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import Foundation

protocol MusicSearchViewInput: class {
    
    func showError(error: Error)
    
    func showNoResults()
    
    func hideNoResults()

    func reloadView()
}
