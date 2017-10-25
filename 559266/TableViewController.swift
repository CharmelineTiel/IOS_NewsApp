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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let baseURL = URL(string: "https://inhollandbackend.azurewebsites.net")
        if let url = URL(string: "/api/Articles", relativeTo: baseURL){  let session = URLSession.shared
            session.dataTask(with: url,      completionHandler:{(optData: Data?,                         response: URLResponse?,                            error: Error?) -> () in    if let data = optData{    do{
                let json = try JSONSerialization.jsonObject(with: data,options: JSONSerialization.ReadingOptions())

                
                let dictionary = json as! [String:AnyObject]

                let article = Article.modelsFromDictionaryArray(array: dictionary["Results"] as! NSArray)
                
                
                for item in article {
                    
                    self.articles.append(item)
                }
                print(article)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }    catch{      print("NO JSON CONVERSION")    }  }  }).resume()}
        
        
        
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

         cell.textLabel?.text = self.articles[indexPath.item].image
        
        let url = URL(string: (self.articles[indexPath.item].image)!)
        let data = try? Data(contentsOf: url!)
        cell.imageView?.image = UIImage(data: data!)

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let data = self.articles[indexPath.item]
        

        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailScreen") as! DetailViewController
        
        
        secondViewController.article = data
        
        self.navigationController?.pushViewController(secondViewController, animated: true)

        
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
