//
//  RepositoryOwner.swift
//  GItHubUserFetcher
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

struct RepositoryOwner: APIResponse {
    
    let login: String
    let avatar_url: String
    
}
