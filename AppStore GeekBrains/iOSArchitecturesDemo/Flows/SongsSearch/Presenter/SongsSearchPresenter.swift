//
//  SongsSearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 29/03/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

class SongsSearchPresenter {
    
    private let model: SongsSearchModel
    
    var viewController: SongsSearchViewController?
    
    init(model: SongsSearchModel) {
        self.model = model
    }

    // MARK: - Input
    func viewDidSearch(with query: String) {
        model.refreshData(with: query) { [weak self] error in
            guard let `self` = self else { return }
            
            self.viewController?.tableView.reloadData()
            
            if self.cellsCount() == 0 {
                self.viewController?.showNoResults()
                if let error = error {
                    self.viewController?.showError(error: error)
                }
            } else {
                self.viewController?.hideNoResults()
            }
        }
    }
    
    func viewDidSelectCell(at indexPath: IndexPath) {
        let song = model.dataSource[indexPath.row]
        print("song selected \(song.trackName)")
        let songDetailsViewController = SongPlayerBuilder().build(with: song)
        self.viewController?.navigationController?.pushViewController(songDetailsViewController, animated: true)
    }

    // MARK: - Ouptut
    
    func cellsCount() -> Int {
        return model.dataSource.count
    }
    
    func configureCell(_ cell: SongTableViewCell, at indexPath: IndexPath) {
        let song = model.dataSource[indexPath.row]
        cell.artistNameLabel.text = song.artistName
        cell.collectionNameLabel.text = song.collectionName
        cell.songNameLabel.text = song.trackName
    }
}

