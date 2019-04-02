//
//  MusicSearcInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 02/04/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import Foundation
import Alamofire

final class MusicSearchInteractor {
    
    private let searchService: ITunesSearchService
    
    init(searchService: ITunesSearchService) {
        self.searchService = searchService
    }
    
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.searchService.getSongs(forQuery: query) { result in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            completion(result)
        }
    }
}
