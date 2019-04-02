//
//  MusicSearchViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Dinar Ilalov on 29/03/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

class MusicSearchViewController: UIViewController {

    // MARK: - Views
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let emptyResultView = UIView()
    private let emptyResultLabel = UILabel()
    
    // MARK: Constants
    private struct Constants {
        static let reuseIdentifier = "reuseId"
    }
    
    let presenter: MusicSearchPresenter
    
    // MARK: - Init
    
    init(presenter: MusicSearchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: - Layout
    
    private func configureUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.addSearchBar()
        self.addTableView()
        self.addEmptyResultView()
        self.setupConstraints()
    }
    
    private func addSearchBar() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.delegate = self
        self.searchBar.searchBarStyle = .minimal
        self.view.addSubview(self.searchBar)
    }
    
    private func addTableView() {
        self.tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        self.tableView.rowHeight = 72.0
        self.tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 0.0)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = true
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
    }
    
    private func addEmptyResultView() {
        self.emptyResultView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyResultView.backgroundColor = .white
        self.emptyResultView.isHidden = true
        
        self.emptyResultLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emptyResultLabel.text = "Nothing was found"
        self.emptyResultLabel.textColor = UIColor.darkGray
        self.emptyResultLabel.textAlignment = .center
        self.emptyResultLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        self.view.addSubview(self.emptyResultView)
        self.emptyResultView.addSubview(self.emptyResultLabel)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8.0),
            self.searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.emptyResultView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.emptyResultView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.emptyResultView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.emptyResultView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.emptyResultLabel.topAnchor.constraint(equalTo: self.emptyResultView.topAnchor, constant: 12.0),
            self.emptyResultLabel.leadingAnchor.constraint(equalTo: self.emptyResultView.leadingAnchor),
            self.emptyResultLabel.trailingAnchor.constraint(equalTo: self.emptyResultView.trailingAnchor)
            ])
    }
}

// MARK: - MusicSearchViewInput
extension MusicSearchViewController: MusicSearchViewInput {
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.emptyResultView.isHidden = false
        self.tableView.isHidden = true
    }
    
    func hideNoResults() {
        self.emptyResultView.isHidden = true
        self.tableView.isHidden = false
    }
    
    func reloadView() {
        self.tableView.reloadData()
        self.searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchBarDelegate
extension MusicSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        self.presenter.viewDidSearch(with: query)
    }
    
}

// MARK: - UITableViewDelegate
extension MusicSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.viewDidSelectCell(at: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension MusicSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? MusicTableViewCell else {
            return dequeuedCell
        }
        self.presenter.configureCell(cell, at: indexPath)
        
        return cell
    }
    
    
}
