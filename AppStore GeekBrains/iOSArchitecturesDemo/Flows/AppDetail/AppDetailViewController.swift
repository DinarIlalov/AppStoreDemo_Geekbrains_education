//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let app: ITunesApp
    
    lazy var headerViewController = AppDetailHeaderViewController(app: self.app)
    lazy var versionViewController = AppDetailVersionViewController(app: self.app)
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        
        addScrollView()
        
        self.addHeaderViewController()
        self.addSeparatorLine(after: headerViewController)
        self.addVersionViewController()
    }
    
    private func addScrollView() {
        self.view.addSubview(scrollView)
        
        // TODO:
        // Вопрос
        // во Вью дебаггере ругается на то, что scroll view content size is ambigious
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    private func addHeaderViewController() {
        self.addChild(self.headerViewController, andPlaceAt: self.scrollView)
        
        self.headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerViewController.view.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.headerViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.headerViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
    }
    
    private func addVersionViewController() {
        
        self.addChild(self.versionViewController, andPlaceAt: self.scrollView)
        
        self.versionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.versionViewController.view.topAnchor.constraint(equalTo: self.headerViewController.view.bottomAnchor),
            self.versionViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.versionViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.versionViewController.view.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
            ])
    }
    
    private func addSeparatorLine(after viewController: UIViewController) {
        let separatorView = UIView()
        self.view.addSubview(separatorView)
        
        separatorView.backgroundColor = .lightGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            separatorView.leftAnchor.constraint(equalTo: viewController.view.leftAnchor, constant: 12),
            separatorView.rightAnchor.constraint(equalTo: viewController.view.rightAnchor, constant: -12),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
            ])
    }
}
