//
//  SongsSearchModel.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 29/03/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class SongsSearchModel {
    
    var dataSource: [ITunesSong] = []
    
    private let searchService = ITunesSearchService()
    
    private func requestSongs(with query: String, completion: @escaping (Error?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            result
                .withValue { songs in
                    self.dataSource = songs
                    completion(nil)
                    return
                }
                .withError {
                    self.dataSource = []
                    completion($0)
            }
        }
    }
    
    func refreshData(with query: String, completion: @escaping (Error?) -> Void) {
        self.requestSongs(with: query, completion: completion)
    }
}
