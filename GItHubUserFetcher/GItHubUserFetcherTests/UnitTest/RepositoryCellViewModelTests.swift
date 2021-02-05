//
//  RepositoryCellViewModelTests.swift
//  GitHubUserFetcherTests
//
//  Created by Thiago Lourin on 20/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import XCTest
@testable import GitHubUserFetcher

class RepositoryCellViewModelTests: XCTestCase {
    
    func testCellMapping_shouldFillAllFields() {
                
        getMockRepositoryItem { (response) in
            let viewModel = RepositoryCellViewModel(repositoryItem: response)
            
            XCTAssertEqual(viewModel.repositoryName, response.name)
            XCTAssertEqual(viewModel.repositoryDescription, response.description)
            XCTAssertEqual(viewModel.forksCount, response.forks_count)
            XCTAssertEqual(viewModel.starsCount, response.stargazers_count)
        }
    }

    private func getMockRepositoryItem(completion: @escaping (RepositoryItem) -> ()) {
        let request = RepositoryRequest()
        let apiClient = APIClientMock()
        
        apiClient.request(request) { (response) in
            XCTAssertTrue(apiClient.apiWasExecuted)
            switch (response) {
            case .success(let result):
                let repository = result as! Repository
                XCTAssert(repository.items.count == 2, "Repository list should have \(repository.items.count) items.")
                completion(repository.items.first!)
                break
            case .failure:
                break
            }
        }
    }
    
}
