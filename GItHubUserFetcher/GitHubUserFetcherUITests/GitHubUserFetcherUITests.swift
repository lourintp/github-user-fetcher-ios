//
//  GitHubUserFetcherUITests.swift
//  GitHubUserFetcherUITests
//
//  Created by Thiago Lourin on 24/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import XCTest

class GitHubUserFetcherUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launchArguments = ["testMode"]
        app.launch()
        
        continueAfterFailure = false
    }

    func test_tableViewMustContainTwoRows() {
        XCTAssert(app.navigationBars["GitHub Users"].exists)
        
        let table = app.tables.element
        
        XCTAssert(table.exists)
        
        let cell = table.cells.allElementsBoundByIndex
        XCTAssert(cell.count == 2)
    }
        
}
