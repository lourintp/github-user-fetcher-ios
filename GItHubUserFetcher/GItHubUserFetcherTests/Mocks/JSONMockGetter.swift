//
//  JSONMockGetter.swift
//  GItHubUserFetcherTests
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation
@testable import GitHubUserFetcher

internal class JSONMockGetter {
    
    static let shared = JSONMockGetter()
    
    func get<T>(jsonFileName: String) -> [T]? where T: APIResponse {
        guard let url = Bundle(for: type(of: self)).url(forResource: jsonFileName, withExtension: "json") else {
            fatalError("Missing file: \(jsonFileName).json")
        }
        
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url)
            let object = try decoder.decode([T].self, from: data)
            
            return object
        } catch let error {
            print(error.localizedDescription)
        }
        
        return []
    }
}
