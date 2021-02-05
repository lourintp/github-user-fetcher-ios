//
//  DataContainer.swift
//  GItHubUserFetcher
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

public struct DataContainer<Results: Decodable> : Decodable {
    public let results: Results
}
