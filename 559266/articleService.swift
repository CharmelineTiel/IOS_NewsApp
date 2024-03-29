//
//  ArticleService.swift
//  559266
//
//  Created by Inholland Haarlem on 02-11-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class ArticleService  {
    
    
    class func requestGetArticles(success:@escaping ([String:AnyObject]) -> Void, failure:@escaping (Error) -> Void) {
    
        
        var headers: HTTPHeaders? = nil
        
        if AuthToken.getToken() != "" {
            
            headers = [
            
                "x-authtoken": AuthToken.getToken(),
                "Accept": "application/json"
            
            ]
            
        }
        

        let url = "https://inhollandbackend.azurewebsites.net/api/Articles/"
        Alamofire.request(url, method: .get,  encoding: URLEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                headers = nil;
                let resJson = responseObject.result.value as! [String : AnyObject]
    
                print(resJson)
                success(resJson)
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }


    class func requestGetMoreArticles(nextId: String, success:@escaping ([String:AnyObject]) -> Void, failure:@escaping (Error) -> Void) {
        
        let amountOfArticles : Int = 20
        
        
        var headers: HTTPHeaders = [:]
        
        if AuthToken.getToken() != "" {
            
            headers = [
                
                "x-authtoken": AuthToken.getToken(),
                "Accept": "application/json"
                
            ]
        }

        let url = "https://inhollandbackend.azurewebsites.net/api/Articles/\(nextId)?count=\(amountOfArticles)"

          Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                let resJson = responseObject.result.value as! [String:AnyObject]

                    
                    success(resJson)
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }

    class func requestLikeArticle(articleId: String, success:@escaping (String) -> Void, failure:@escaping (Error) -> Void) {
        
        
        var headers: HTTPHeaders = [:]
        
        if AuthToken.getToken() != "" {
            
            headers = [
                
                "x-authtoken": AuthToken.getToken(),
                "Accept": "application/json"
                
            ]
        }
        
        let url = "https://inhollandbackend.azurewebsites.net/api/Articles/\(articleId)/like"
        
        Alamofire.request(url, method: .put, encoding: JSONEncoding.default, headers: headers).responseJSON{ (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
   
                success("gelukt")
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    class func requestUnlikeArticle(articleId: String, success:@escaping (String) -> Void, failure:@escaping (Error) -> Void) {
        
        
        var headers: HTTPHeaders = [:]
        
        if AuthToken.getToken() != "" {
            
            headers = [
                
                "x-authtoken": AuthToken.getToken(),
                "Accept": "application/json"
                
            ]
        }
        
        let url = "https://inhollandbackend.azurewebsites.net/api/Articles/\(articleId)/like"
        
        Alamofire.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers).responseJSON{ (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                
                success("gelukt")
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
}
