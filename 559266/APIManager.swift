//
//  APIManager.swift
//  559266
//
//  Created by Inholland Haarlem on 01-11-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import Foundation

class APIManager : APIManagerBase{
    let baseURL = URL(string:"https://inhollandbackend.azurewebsites.net")
    
    func register(withUserName userName: String,                  andPassword password: String,                  withSuccess success: ()->(),                    orFailure failure: (String)->())
    {
        
    }
    func login(withUserName userName: String,              andPassword password: String,               withSuccess success: (String)->(),                 orFailure failure: (String)->())
    {
        
        
    }
    
    func getFeeds(withSuccess success: ([[String:Any]])->(),                  orFailure failure: (String)->()){
        
        let result = get(atPath: "/Articles", withHeaders: [:], andParameters: [:], withSuccess: {_ in print("error")}, orFailure: {_ in print("error")})
        
        

//        func get(atPath path: String,
//                 withHeaders headers: [String:String] = [:],
//                 andParameters parameters: [String:AnyObject] = [:],
//                 withSuccess success: @escaping (Any) ->(),
//                 orFailure failure: @escaping (String) -> ()) -> URLSessionDataTask{
//            return perform(Method: "GET", fromPath: path, withHeaders: headers, andParameters: parameters, withSuccess: success, orFailure: failure)
//        }
        
        }
    func getArticles(withSuccess success: ([[String:Any]], Int)->(),                      orFailure failure: (String)->()){
        
        
        }
    
}
