//
//  DetailViewController.swift
//  559266
//
//  Created by Inholland Haarlem on 24-10-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var article:Article?


    @IBOutlet weak var urlBtn: UIButton!
    @IBOutlet weak var likedBtn: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var summary: UITextView!
      var articleId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    

    func likeArticle(){
        
        
        if (article?.isLiked == true) {
            
            
            ArticleService.requestUnlikeArticle(articleId:  "\(articleId)",success: {
                (JSONResponse) -> Void in
                
            }) {
                (error) -> Void in
                print(error)
            }
            article?.isLiked = false
            self.likedBtn.setTitle("not liked", for: .normal)
            
            
        }else{
            
            ArticleService.requestLikeArticle(articleId:  "\(articleId)",success: {
                (JSONResponse) -> Void in
                
            }) {
                (error) -> Void in
                print(error)
            }
            
            article?.isLiked = true
            self.likedBtn.setTitle("Liked", for: .normal)
            
        }
        
    }
    func getFullArticle()
    {
    
        guard let url = URL(string: (article?.url)!) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if Reachability.isConnectedToNetwork(){
            
            if (article?.isLiked)! {
                
                likedBtn.setTitle("Liked", for: .normal)
            }else{
                
                likedBtn.setTitle("Not liked", for: .normal)
            }
            
            
            if AuthToken.getToken() != "" {
                
                likedBtn.isEnabled = true
                
            }else{
                
                likedBtn.isEnabled = false
                
            }
            if let id = article?.id {
                articleId = "\(id)"
            }
            
            titleLbl.text = article?.title
            
            summary.text = article?.summary
            
            likedBtn.addTarget(self, action:#selector(likeArticle), for: .touchUpInside)
            urlBtn.addTarget(self, action:#selector(getFullArticle), for: .touchUpInside)

            let url = URL(string: (article?.image!)!)
            let data = try? Data(contentsOf: url!)
            image.image = UIImage(data: data!)
            
        }else{
            
            alertMessage()
        }
        
        
        
    }
    
    
    func alertMessage()
    {
        
        let alertController = UIAlertController(title: "Geen verbinding", message:
            "Geen internet verbinding..", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Probeer opnieuw", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            
            self.loadView()
        }
        
        
        alertController.addAction(okAction)
        self.present(alertController, animated:true, completion:nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
