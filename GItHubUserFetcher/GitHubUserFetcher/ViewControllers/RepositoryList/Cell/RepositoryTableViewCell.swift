//
//  RepositoryTableViewCell.swift
//  GitHubUserFetcher
//
//  Created by Thiago Lourin on 20/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import UIKit
import Alamofire

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var forkIconImageView: UIImageView!
    @IBOutlet weak var forkNumberLabel: UILabel!
    @IBOutlet weak var starIconImageView: UIImageView!
    @IBOutlet weak var starNumberLabel: UILabel!
    
    weak var photosManager: PhotoManager?
    var request: Request?
    var photoUrl: String!
        
    func setup(with viewModel: RepositoryCellViewModel, photoManager: PhotoManager) {
        repositoryNameLabel.text = viewModel.repositoryName
        repositoryDescriptionLabel.text = viewModel.repositoryDescription
        usernameLabel.text = viewModel.username
        forkIconImageView.image = viewModel.forkImage
        forkNumberLabel.text = "\(viewModel.forksCount)"
        starIconImageView.image = viewModel.starImage
        starNumberLabel.text = "\(viewModel.starsCount)"
        
        photoUrl = viewModel.userAvatarUrl ?? ""
        photosManager = photoManager
        reset()
        loadImage()
    }
    
    func reset() {
        userAvatarImageView.image = nil
        request?.cancel()
    }

    func loadImage() {
        if let image = photosManager?.cachedImage(for: photoUrl) {
            populate(with: image)
            return
        }
        downloadImage()
    }

    func downloadImage() {
        request = photosManager?.retrieveImage(for: photoUrl) { image in
            self.populate(with: image)
        }
    }

    func populate(with image: UIImage) {
        userAvatarImageView.image = image
    }
    
}
