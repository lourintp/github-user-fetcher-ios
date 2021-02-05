//
//  Result.swift
//  GItHubUserFetcher
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(APIResponse)
    case failure(Error?)
}

typealias ResultCallback<Value> = (Result<Value>) -> Void
