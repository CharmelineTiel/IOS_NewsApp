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

class ArticleService  {
    
    
    class func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
//
//func getArticles() -> [Article]{
//    
//    var articles = [Article]()
//
//   _ = self.get(
//        
//    atPath: "Articles", withHeaders: [:], andParameters: [:],
//        withSuccess: {(json: Any) -> () in let results = json
//        
//            
//            //print(results)
//    
//        let dictionary = results as! [String:AnyObject]
//        let array = Article.modelsFromDictionaryArray(array: dictionary["Results"] as! NSArray)
// 
//     
//            for item in array
//            {
//                articles.append(item)
//            }
//
//            
//    },
//        
//        orFailure: {(String) -> () in print("failed to load content")}
//        
//        )
//    
//    for item in articles
//    {
//        print(item.title as Any)
//    }
//    return articles
//    }
//    
//    

}
