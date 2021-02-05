//
//  APIClientFactory.swift
//  GitHubUserFetcher
//
//  Created by Thiago Lourin on 23/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

class APIClientFactory {
    
    static func getAPIClientInstance() -> APIClientProtocol {
        if (ProcessInfo.processInfo.arguments.contains("testMode")) {
            return APIClientMock()
        }
        return APIClient()
    }
    
}
