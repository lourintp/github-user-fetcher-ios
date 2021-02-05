//
//  RepositoryTableViewController.swift
//  GitHubUserFetcher
//
//  Created by Thiago Lourin on 20/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import UIKit

class RepositoryTableViewController: UITableViewController {

    private let cellIdentifier = "repositoryCell"
    let viewModel = RepositoryViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    private let photoManager = PhotoManager()
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        getRepository(.forks)
        setupSearchBar()
        setupNavigationBar()
    }
    
    private func getRepository(_ orderBy: SortFactor) {
        viewModel.getRepositoryList(language: .java, orderBy: orderBy, success: {
            print("Success")
            self.tableView.reloadData()
        }) { (errorString) in
            print(errorString)
        }
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for repositories or users..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupNavigationBar() {
        let rightButton = UIBarButtonItem(image: UIImage(named: "filterIcon"), style: .plain, target: self, action: #selector(didTapFilter))
        navigationItem.rightBarButtonItem = rightButton
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOrRows(isFiltering)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RepositoryTableViewCell
        
        if let cellViewModel = viewModel.cellViewModel(at: indexPath, isFiltering) {
            cell.setup(with: cellViewModel, photoManager: photoManager)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func didTapFilter(_ sender: Any) {
        showActionSheetWithOptions(title: "Choose a sort factor", options: [SortFactor.forks.rawValue, SortFactor.stars.rawValue]) { [weak self] (chosen) in
            self?.getRepository(SortFactor(rawValue: chosen)!)
            self?.tableView.reloadData()
        }
    }
    
    func showActionSheetWithOptions(title: String, options: [String], callback: @escaping (String) -> ()) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        
        for (index, option) in options.enumerated() {
            let action = UIAlertAction(title: option.capitalized, style: .default) { (action) in
                callback(options[index])
            }
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RepositoryTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.setupFilteredRows(searchController.searchBar.text!)
        tableView.reloadData()
    }
}
