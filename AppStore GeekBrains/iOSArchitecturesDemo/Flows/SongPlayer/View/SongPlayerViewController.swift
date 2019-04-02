//
//  SongPlayerViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 01/04/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

class SongPlayerViewController: UIViewController {

    // MARK: Outlets
    
    private let albumImageView: UIImageView = UIImageView()
    private let songNameLabel: UILabel = UILabel()
    private let progressView: UIProgressView = UIProgressView()
    private let timeLeftLabel: UILabel = UILabel()
    private let playPauseButton: UIButton = UIButton()
    
    // MARK: Properties
    
    private let viewModel: SongPlayerViewModel
    
    // MARK: - Init
    
    init(viewModel: SongPlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.setupConstraints()
        self.bindViewModel()
    }

    // MARK: - Layout
    
    private func configureUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white;
//        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Song"
        
        self.addAlbumImageView()
        self.addSongLabel()
        self.addProgressView()
        self.addTimeLeftLabel()
        self.addPlayPauseButton()
    }
    
    private func addAlbumImageView() {
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.image = #imageLiteral(resourceName: "Image")
        self.view.addSubview(albumImageView)
    }
    
    private func addSongLabel() {
        self.songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.songNameLabel.numberOfLines = 2
        self.songNameLabel.font = UIFont.systemFont(ofSize: 25)
        self.songNameLabel.textAlignment = .center
        self.songNameLabel.text = "<no name>"
        self.view.addSubview(songNameLabel)
    }
    
    private func addProgressView() {
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(progressView)
    }
    
    private func addTimeLeftLabel() {
        
        self.timeLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        self.timeLeftLabel.textColor = .lightGray
        self.timeLeftLabel.font = UIFont.systemFont(ofSize: 15)
        self.timeLeftLabel.text = "0:00"
        self.view.addSubview(timeLeftLabel)
    }
    
    private func addPlayPauseButton() {
        self.playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        self.playPauseButton.setImage(#imageLiteral(resourceName: "ic_play"), for: .normal)
        self.playPauseButton.setImage(#imageLiteral(resourceName: "ic_pause"), for: .selected)
        self.playPauseButton.addTarget(self, action: #selector(playPauseButtonDidTap(_:)), for: .touchUpInside)
        self.view.addSubview(playPauseButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            albumImageView.heightAnchor.constraint(equalToConstant: self.view.frame.size.width/2),
            albumImageView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width/2),
            albumImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
            ])
        
        NSLayoutConstraint.activate([
            songNameLabel.topAnchor.constraint(equalTo: self.albumImageView.bottomAnchor, constant: 16),
            songNameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            songNameLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            songNameLabel.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: self.songNameLabel.bottomAnchor, constant: 16),
            progressView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            progressView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            ])
        
        NSLayoutConstraint.activate([
            timeLeftLabel.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 8),
            timeLeftLabel.rightAnchor.constraint(equalTo: self.progressView.rightAnchor, constant: 0),
            ])
        
        NSLayoutConstraint.activate([
            playPauseButton.topAnchor.constraint(equalTo: self.timeLeftLabel.bottomAnchor, constant: 16),
            playPauseButton.heightAnchor.constraint(equalToConstant: 40),
            playPauseButton.widthAnchor.constraint(equalToConstant: 40),
            playPauseButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            ])
    }
    
    // MARK: - Binding
    private func bindViewModel() {
        self.viewModel.isPlaying.addObserver(self) { [weak self] (isPlaying, _) in
            self?.playPauseButton.isSelected = isPlaying
        }
        self.viewModel.songName.addObserver(self) { [weak self] (songName, _) in
            self?.songNameLabel.text = songName
        }
        self.viewModel.songImage.addObserver(self) { [weak self] (songImage, _) in
            self?.albumImageView.image = songImage
        }
        self.viewModel.songPlayingProgress.addObserver(self) { [weak self] (songPlayingProgress, _) in
            self?.progressView.progress = songPlayingProgress
        }
        self.viewModel.songTimeLeftString.addObserver(self) { [weak self] (songTimeLeftString, _) in
            self?.timeLeftLabel.text = songTimeLeftString
        }
        
        self.viewModel.initiateBunding()
    }
    
    // MAKR: - Actions
    @objc private func playPauseButtonDidTap(_ sender: UIButton) {
        viewModel.playPauseButtonDidTap()
    }
}
