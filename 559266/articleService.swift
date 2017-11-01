//
//  backend.swift
//  559266
//
//  Created by Inholland Haarlem on 24-10-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import Foundation


public class articleService {
    
    
    let manager : APIManager
    
    init()

    {
        
            manager.getArticles(withSuccess: <#T##([[String : Any]], Int) -> ()#>, orFailure: <#T##(String) -> ()#>)
    }

    

//    func getArticles()
//    
//    {
//        
//        let config = URLSessionConfiguration.default // Session Configuration
//        let session = URLSession(configuration: config) // Load configuration into Session
//        let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/articles")!
//        
//        let task = session.dataTask(with: url, completionHandler: {
//            (data, response, error) in
//            
//            if error != nil {
//                
//                print(error!.localizedDescription)
//                
//            } else {
//                
//                do {
//                    
//                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
//                    {
//                        
//                        //self.articles = json["Results"] as? [Article]
//                        
//                        //Implement your logic
//                        print(json)
//                        
//                    }
//                    
//                } catch {
//                    
//                    print("error in JSONSerialization")
//                    
//                }
//                
//                
//            }
//            
//        })
//        task.resume()
//    }
//    
    

    }
