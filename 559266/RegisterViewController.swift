//
//  RegisterViewController.swift
//  559266
//
//  Created by Inholland Haarlem on 04-11-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func RegisterBtn(_ sender: Any) {
        
        
        if username.text != "" && password.text != ""{
            
            
            UserService.requestRegister(username: username.text!, password: password.text!, success: {
                (JSONResponse) -> Void in
                
                AuthToken.setToken(authToken: JSONResponse)
                
                //navigate to login
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginScreen") 
                self.present(nextViewController, animated:true, completion:nil)
                
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
