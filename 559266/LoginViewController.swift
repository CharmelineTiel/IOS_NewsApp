//
//  ViewController.swift
//  559266
//
//  Created by Inholland Haarlem on 24-10-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func loginBtn(_ sender: Any) {
        
        if username.text != "" && password.text != ""{
            
            
            UserService.requestLogin(username: username.text!, password: password.text!, success: {
                (JSONResponse) -> Void in
                print(JSONResponse)
                
                
 
            }) {
                (error) -> Void in
                print(error)
            }
        }
            else{
            
            print("voer aub alles in")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

