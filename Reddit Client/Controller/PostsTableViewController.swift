//
//  PostsTableViewController.swift
//  Reddit Client
//
//  Created by Jonathan Chua on 10/10/17.
//  Copyright © 2017 Jonathan Chua. All rights reserved.
//

import UIKit
import Alamofire

class PostsTableViewController: UITableViewController {
    
    var subredditURL: String?
    var subredditInput: String?
    // let redditData = RedditDataModel()

    var posts = [RedditPost]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CustomPostCell", bundle: nil), forCellReuseIdentifier: "postCell")

        if let subredditURL = subredditURL {
            title = subredditInput
            callAPI(url: subredditURL)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        if let cell = cell as? CustomPostCell {
            let post = posts[indexPath.row]
            cell.titleLabel.text = post.title
            cell.authorLabel.text = post.author
        }
        return cell
    }

    struct Response: Codable {
        struct Data: Codable {
            struct Child: Codable { let data: RedditPost }
            let children: [Child]
        }
        let data: Data
    }

    func callAPI(url: String) {
        Alamofire.request(url).responseData { [weak self] response in
            guard response.result.isSuccess, let vc = self else {
                return
            }
            print(response.result.value!)
            //self.redditData.apiResponse = response.data!
            do {
                let decoder = JSONDecoder()
                let r = try decoder.decode(Response.self, from: response.data!)
                //print("Title: \(r.data.children[0].data.title)")
                vc.posts = r.data.children.map { $0.data }
                print(vc.posts)
            }
            catch {
                print("Error: \(error)")
            }
        }
        
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
