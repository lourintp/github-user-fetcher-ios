//
//  UIApplication+Extension.swift
//  GItHubUserFetcher
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static var githubApiRootUrl: String {
        return Bundle.main.object(forInfoDictionaryKey: "GitHubRootURL") as? String ?? ""
    }
    
}
