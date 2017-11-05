//
//  UserService.swift
//  559266
//
//  Created by Inholland Haarlem on 03-11-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class UserService  {
    
    
    class func requestLogin(username: String, password:String, success:@escaping (String) -> Void, failure:@escaping (Error) -> Void) {

        let url = "https://inhollandbackend.azurewebsites.net/api/users/login"
        let parameters: [String: Any] = ["UserName": "\(username)", "Password": "\(password)"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                let resJson = responseObject.result.value as?  [String:Any]
                if let token = resJson?["AuthToken"]{
                    
                    
                    success(token as! String)
                    
                }

                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
}

    
    class func requestRegister(username: String, password:String, success:@escaping ([String:Any]) -> Void, failure:@escaping (Error) -> Void) {
        
        let url = "https://inhollandbackend.azurewebsites.net/api/users/register"
        let parameters: [String: Any] = ["UserName": "\(username)", "Password": "\(password)"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {(responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                
                if responseObject.result.isSuccess {
                    let resJson = responseObject.result.value as?  [String:Any]
     
                        
                        success(resJson!)
                  
                    
                
                if responseObject.result.isFailure {
                    let error : Error = responseObject.result.error!
                    failure(error)
                }
            }
        }
    }
    
}
}
