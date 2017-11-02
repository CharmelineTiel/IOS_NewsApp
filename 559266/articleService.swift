//
//  ArticleService.swift
//  559266
//
//  Created by Inholland Haarlem on 02-11-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import Foundation

class ArticleService : APIManagerBase {
    

func getArticles() -> [Article]{
    
    var articles = [Article]()

   var this = self.get(
        
    atPath: "Articles", withHeaders: [:], andParameters: [:],
        withSuccess: {(json: Any) -> () in let results = json
        
            //print(results)
    
        let dictionary = results as! [String:AnyObject]
        let array = Article.modelsFromDictionaryArray(array: dictionary["Results"] as! NSArray)
 
            print(array)
            articles = array
//
//            for item in array
//            {
//                articles.append(item)
//            }
            

    },
        
        orFailure: {(String) -> () in print("failed to load content")}
        
        )
    
    return articles
    }
    

}
