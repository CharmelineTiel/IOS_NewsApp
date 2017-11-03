//
//  AuthToken.swift
//  559266
//
//  Created by Inholland Haarlem on 03-11-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import Foundation

public final class AuthToken{
    
    
    public static var authToken : String?
    
    private init() {
        
     
    }

   static func setToken(authToken : String?)
    {
       self.authToken = authToken!
    }
    
    static func getToken() -> String
    {

            return authToken!


    }

}
