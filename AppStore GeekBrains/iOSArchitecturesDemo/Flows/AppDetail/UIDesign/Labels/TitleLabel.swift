//
//  TitleLabel.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 29/03/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {

    init() {
        super.init(frame: .zero)
        self.textColor = .black
        self.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
