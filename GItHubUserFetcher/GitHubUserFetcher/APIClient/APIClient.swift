//
//  APIClient.swift
//  GItHubUserFetcher
//
//  Created by Thiago Lourin on 19/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

protocol APIClientProtocol {
    func request<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>)
}

public class APIClient: APIClientProtocol {
            
    func request<T: APIRequest>(_ request: T, completion: @escaping (Result<DataContainer<T.Response>>) -> Void) {
        let endpoint: URLRequest
        
        do {
            endpoint = try getRequest(for: request, url: UIApplication.githubApiRootUrl)
        } catch let error{
            completion(.failure(error))
            return
        }
        
        Alamofire.request(endpoint).validate().responseData { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(responseData.error))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(response))
                return
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    private func getRequest<T: APIRequest>(for request: T, url: String, _ isTrakt: Bool = true) throws -> URLRequest {
        guard let baseURL = URL(string: request.resourcePath, relativeTo: URL(string: url)) else {
            fatalError("Bad resource name: \(request.resourcePath)")
        }
        
        print(baseURL.absoluteString)
        
        var requestData = URLRequest(url: baseURL)
        
        requestData.httpMethod = HTTPMethod.get.rawValue
        requestData.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return requestData
    }
    
}
