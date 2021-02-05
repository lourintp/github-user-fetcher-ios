//
//  RepositoryParseTests.swift
//  GitHubUserFetcherTests
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import XCTest
@testable import GitHubUserFetcher

class RepositoryParseTests: XCTestCase {
           
    func testParsingRepository_ReturnsRepositoryList() {
        let request = RepositoryRequest()
        let apiClient = APIClientMock()
        
        apiClient.request(request) { (response) in
            XCTAssertTrue(apiClient.apiWasExecuted)
            switch (response) {
            case .success(let result):
                let repository = result as! Repository
                XCTAssert(repository.items.count == 2, "Repository list should have \(repository.items.count) items.")
                break
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "Shouldn't have any error.")
                break
            }
        }                
    }

    func testParsingRepository_withError_throwsError() {
        let request = RepositoryRequest()
        let apiClient = APIClientMock()
        
        apiClient.hasError = true
        
        apiClient.request(request) { (response) in
            switch (response) {
            case .success(_):
                XCTFail("Shouldn't be successful.")
                break
                
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
