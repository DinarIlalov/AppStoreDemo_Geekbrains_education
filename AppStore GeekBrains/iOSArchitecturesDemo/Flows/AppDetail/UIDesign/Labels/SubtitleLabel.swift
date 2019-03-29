//
//  SubtitleLabel.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 29/03/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

class SubtitleLabel: UILabel {

    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .lightGray
        self.font = UIFont.systemFont(ofSize: 14.0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
