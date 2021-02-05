//
//  RepositoryViewModel.swift
//  GitHubUserFetcher
//
//  Created by Thiago Lourin on 24/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

class RepositoryViewModel {
        
    private(set) var rows = [RepositoryCellViewModel]()
    private(set) var filteredRows = [RepositoryCellViewModel]()
    
    func numberOrRows(_ isFiltering: Bool) -> Int {
        return isFiltering ? filteredRows.count : rows.count    
    }
    
    func cellViewModel(at indexPath: IndexPath, _ isFiltering: Bool) -> RepositoryCellViewModel? {
        if (isFiltering) {
            return filteredRows[indexPath.row]
        }
        return rows[indexPath.row]
    }
    
    func setupRows(items: [RepositoryItem]) {
        rows = items.map( { RepositoryCellViewModel(repositoryItem: $0 ) } )
    }
    
    func setupFilteredRows(_ searchText: String) {
        filteredRows = rows.filter( {
            $0.repositoryName.lowercased().contains(searchText.lowercased()) ||
            $0.username.lowercased().contains(searchText.lowercased())
        } )
    }        
    
    func getRepositoryList(language: Language, orderBy: SortFactor, success: @escaping () -> (), failure: @escaping (String) -> () ) {
        let request = RepositoryRequest(language: language, page: 1, sort: orderBy)
        
        let apiClient = APIClientFactory.getAPIClientInstance()
        apiClient.request(request) { (result) in
            switch result {
            case .success(let response):
                let repository = response as! Repository
                self.setupRows(items: repository.items)
                success()
                break
            case .failure(let error):
                failure(error?.localizedDescription ?? "Couldn't get repository list")
                break
            }
        }
    }    
}
