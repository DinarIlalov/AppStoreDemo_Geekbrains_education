//
//  Date.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 02/04/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import Foundation

import Foundation

extension Date {
    func toRuDateString() -> String {
        return DateFormatter.stringRuFormatter.string(from: self)
    }
    
    func toTimeString() -> String {
        return DateFormatter.timeStringFormatter.string(from: self)
    }
}

extension DateFormatter {
    static var stringRuFormatter: DateFormatter = {
        let monthFormat = "MMM"
        let yearFormat = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd \(monthFormat)\(yearFormat)"
        return dateFormatter
    }()
    
    static var timeStringFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        return dateFormatter
    }()
}
