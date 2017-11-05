//
//  TableViewController.swift
//  559266
//
//  Created by Inholland Haarlem on 24-10-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var articles = [Article]()
    var nextId : Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if Reachability.isConnectedToNetwork(){
            
             initialLoadArticles()
        }else{
            
           alertMessage()
        }
        
        
    }
    
    
    func initialLoadArticles(){
        
        
        ArticleService.requestGetArticles(success: {
            (JSONResponse) -> Void in
         
            let myArticles = Article.modelsFromDictionaryArray(array: JSONResponse["Results"] as! NSArray)

            self.nextId = JSONResponse["NextId"] as! Int
            for item in myArticles{
                
                self.articles.append(item)
                
            }
        
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) {
            (error) -> Void in
            print(error)
        }
        
        
    }
    func loadMoreArticles(){
        
        
        ArticleService.requestGetMoreArticles(nextId: "\(nextId)",success: {
            (JSONResponse) -> Void in
           
            
            let myArticles = Article.modelsFromDictionaryArray(array: JSONResponse["Results"] as! NSArray)
            
            self.nextId = JSONResponse["NextId"] as! Int
    
            for item in myArticles {
                
                self.articles.append(item)
            }
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) {
            (error) -> Void in
            print(error)
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.articles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell:ArticleCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleCell
        
        if Reachability.isConnectedToNetwork(){
        
       
        cell.Title?.text = self.articles[indexPath.item].title
        let url = URL(string: (self.articles[indexPath.item].image)!)
        let data = try? Data(contentsOf: url!)
        cell.thumbnail.image = UIImage(data: data!)
        
        if self.articles[indexPath.item].isLiked as Bool {
            cell.LikedLbl.text = "Liked"
        }else{
            cell.LikedLbl.text = "Not liked"
        }
            
        
        }else{
            
            alertMessage()
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath)
    {
        
       //TODO: add pending requests check
        if (indexPath.row == self.articles.count - 1) {
            
            if Reachability.isConnectedToNetwork(){
                
                 loadMoreArticles()
            }else{
               
                
            }
            
          
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let data = self.articles[indexPath.item]
        
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailScreen") as! DetailViewController
        
        
        secondViewController.article = data
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        if Reachability.isConnectedToNetwork(){
         
             self.tableView.reloadData()
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
            
            self.tableView.reloadData()
        }
        
        
        alertController.addAction(okAction)
        self.present(alertController, animated:true, completion:nil)
        
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
