//
//  Router.swift
//  559266
//
//  Created by Inholland Haarlem on 03-11-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "https://inhollandbackend.azurewebsites.net/api/"
    
    case get(String)
    case create([String: Any])
    case put(String)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .get:
                return .get
            case .create:
                return .post
            case .put:
                return .put
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .get, .put:
                return nil
            case .create(let newUser):
                return (newUser)
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self {
            case .get(let id):
                relativePath = "Articles/\(id)"
            case .create:
                relativePath = "register"
            case .put(let id):
                relativePath = "Articles/\(id)"
            }
            
            var url = URL(string: Router.baseURLString)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: params)
    }
}
