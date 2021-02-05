//
//  APIRequest.swift
//  GItHubUserFetcher
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

protocol APIRequest: Encodable {
    
    var resourcePath: String { get }
    var mockFileName: String { get }
    
    associatedtype Response: APIResponse
    
}
