//
//  Router.swift
//  heart2heart
//
//  Created by Tega Esabunor on 22/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import Foundation
import Alamofire

enum HeartToHeartRouter : URLRequestConvertible {
    static let baseUrlString = "https//blahblah.blah"
    
    case get(Int)
    case create([String:Any])
    case put((Int, [String:Any]))
    case delete(Int)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .get:
                return .get
            case .create:
                return .post
            case .delete:
                return .delete
            case .put:
                return .put
            }
        }
        
        let params : ([String:Any])? = {
            switch self {
            case .get, .delete:
                return nil
            case .create(let para):
                return (para)
            case let .put((n, para)):
                return para
            }
        }()
        
        let url: URL = {
            
            let relativePath: String?
            switch self {
            case .get(let number):
               relativePath = "heart/\(number)"
            case .delete(let number):
                relativePath = "heart/\(number)"
            case let .put((number, para)):
                relativePath = "heart/\(number)"
            case .create:
                relativePath = "heart"
            }
            
            var url = URL(string: HeartToHeartRouter.baseUrlString)
            if let relativePath = relativePath {
                //url = url?.appendPathComponent(relativePath)
            }
            return url!
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
}
