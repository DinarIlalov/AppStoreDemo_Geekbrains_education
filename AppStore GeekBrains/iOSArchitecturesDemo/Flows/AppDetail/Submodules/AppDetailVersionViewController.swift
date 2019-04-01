//
//  AppDetailVersionViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 29/03/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

class AppDetailVersionViewController: UIViewController {

    // MARK: Outlets
    private(set) lazy var titleLabel: TitleLabel = {
        let label = TitleLabel()
        return label
    }()
    
    private(set) lazy var versionLabel: SubtitleLabel = {
        let label = SubtitleLabel()
        return label
    }()
    
    private(set) lazy var versionDateLabel: SubtitleLabel = {
        let label = SubtitleLabel()
        return label
    }()
    
    private(set) lazy var descriptionLabel: SimpleLabel = {
        let label = SimpleLabel()
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var versionHistoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("История версий", for: .normal)
        return button
    }()
    
    // MARK: Propeerties
    private let app: ITunesApp
    
    // MARK: Init
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifiCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.fillData()
    }

    // MARK: - Private
    private func setupLayout() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.versionLabel)
        self.view.addSubview(self.versionDateLabel)
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.versionHistoryButton)
        
        NSLayoutConstraint.activate([
            
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0),
//            self.titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0),
            
            self.versionHistoryButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.versionHistoryButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.versionHistoryButton.widthAnchor.constraint(equalToConstant: 130),
            self.versionHistoryButton.heightAnchor.constraint(equalToConstant: 30),
            
            self.versionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12.0),
            self.versionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0),
//            self.versionLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor),

            self.versionDateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12.0),
            self.versionDateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.versionLabel.bottomAnchor, constant: 12.0),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16.0),
            ])
    }
    
    private func fillData() {
        self.titleLabel.text = "Что нового"
        self.versionLabel.text = app.version
        // в дату из JSON декодить не захотел
        // а я не хочу форматировать в норм строку)
        self.versionDateLabel.text = app.currentVersionReleaseDate
        self.descriptionLabel.text = app.appDescription
//        self.subtitleLabel.text = app.company
//        self.ratingLabel.text = app.averageRating >>- { "\($0)" }
    }
}
