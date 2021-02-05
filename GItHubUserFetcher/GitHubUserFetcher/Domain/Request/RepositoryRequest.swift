//
//  RepositoryRequest.swift
//  GItHubUserFetcher
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

enum Language: String {
    case java = "Java"
    case cSharp = "CSharp"
    case swift = "Swift"
}

enum SortFactor: String {
    case stars = "stars"
    case forks = "forks"
}

struct RepositoryRequest: APIRequest {
    
    let language: String
    let page: Int
    let sort: String
    
    init(language: Language, page: Int, sort: SortFactor) {
        self.language = language.rawValue
        self.page = page
        self.sort = sort.rawValue
    }
    
    init() {
        self.language = ""
        self.page = 1
        self.sort = ""
    }
    
    var resourcePath: String {
        return "/search/repositories?q=language:\(language)&sort=\(sort)&page=\(page)"
    }
    
    var mockFileName: String {
        return "Repository"
    }
    
    typealias Response = Repository
}
