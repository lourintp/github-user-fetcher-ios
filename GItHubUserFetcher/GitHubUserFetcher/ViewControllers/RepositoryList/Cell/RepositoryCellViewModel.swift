//
//  RepositoryCellViewModel.swift
//  GitHubUserFetcher
//
//  Created by Thiago Lourin on 20/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RepositoryCellViewModel {
    
    let repositoryName: String
    let repositoryDescription: String
    let starsCount: Int
    let forksCount: Int
    let userAvatarUrl: String?
    let username: String
    let forkImage: UIImage
    let starImage: UIImage
    
    init(repositoryItem: RepositoryItem) {
        self.repositoryName = repositoryItem.name
        self.repositoryDescription = repositoryItem.description ?? "No description"
        self.starsCount = repositoryItem.stargazers_count
        self.forksCount = repositoryItem.forks_count
        self.userAvatarUrl = repositoryItem.owner.avatar_url
        self.username = repositoryItem.owner.login
        self.forkImage = UIImage(named: "forkIcon")!
        self.starImage = UIImage(named: "starIcon")!
    }
}
