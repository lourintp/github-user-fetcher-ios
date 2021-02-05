//
//  RepositoryItem.swift
//  GItHubUserFetcher
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

struct RepositoryItem: APIResponse {
 
    let name: String
    let description: String?
    let forks_count: CLong
    let stargazers_count: CLong
    let owner: RepositoryOwner
    
}
