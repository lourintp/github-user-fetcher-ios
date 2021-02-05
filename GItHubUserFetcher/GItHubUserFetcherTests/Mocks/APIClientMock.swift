//
//  APIClientMock.swift
//  GItHubUserFetcherTests
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation
@testable import GitHubUserFetcher

struct MockError: Error {
    var localizedDescription: String
}

class APIClientMock: APIClientProtocol {
    
    var apiWasExecuted = false
    var hasError = false
    
    func request<T>(_ request: T, completion: @escaping (Result<DataContainer<T.Response>>) -> Void) where T : APIRequest {
        apiWasExecuted = true
        
        if (hasError) {
            completion(.failure(MockError(localizedDescription: "Error")))
            return
        }
        
        let list = get(jsonFileName: request.mockFileName)
        let decoder = JSONDecoder()
        if let data = list {
            do {
                let response = try decoder.decode(T.Response.self, from: data)
                completion(.success(response))
            }
            catch let error {
                completion(.failure(error))
            }
        }
    }
    
    private func get(jsonFileName: String) -> Data? {
        guard let url = Bundle(for: type(of: self)).url(forResource: jsonFileName, withExtension: "json") else {
            fatalError("Missing file: \(jsonFileName).json")
        }
        do {
            return try Data(contentsOf: url)
        } catch let error {
            print(error.localizedDescription)
        }
        
        return nil
    }        
}
