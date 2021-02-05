//
//  Repository.swift
//  GItHubUserFetcher
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

struct Repository: APIResponse {
    
    let total_count: CLong
    let incomplete_results: Bool
    let items: [RepositoryItem]
    
}
