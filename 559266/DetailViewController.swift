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


    @IBOutlet weak var likedBtn: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var summary: UITextView!
      var articleId = ""
    //var articleId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        if let id = article?.id {
            articleId = "\(id)"
        }
        
        titleLbl.text = article?.title
     
        summary.text = article?.summary
        
        likedBtn.addTarget(self, action:#selector(likeArticle), for: .touchUpInside)
        
        //print(article?.isLiked as String)
        let url = URL(string: (article?.image!)!)
        let data = try? Data(contentsOf: url!)
        image.image = UIImage(data: data!)
        
    }

    func likeArticle(){
        
        ArticleService.requestLikeArticle(articleId:  "\(articleId)",success: {
            (JSONResponse) -> Void in
            
            if (self.article?.isLiked)! {
            self.likedBtn.setTitle("Liked", for: .normal)
                
            }else{
                
                 self.likedBtn.setTitle("not liked", for: .normal)
            }
             print(self.article?.id as Any)
        }) {
            (error) -> Void in
            print(error)
        }
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
