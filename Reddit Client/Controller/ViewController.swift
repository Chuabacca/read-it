//
//  ViewController.swift
//  Reddit Client
//
//  Created by Jonathan Chua on 10/10/17.
//  Copyright © 2017 Jonathan Chua. All rights reserved.
//

// x guard against empty string
// x if empty display error "please enter subreddit"
// x and make button red
// x if valid entry, remove error


import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var subredditURL: String = ""

    @IBOutlet weak var subredditField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if subredditField.text == "" {
            goButton.backgroundColor = UIColor.red
            errorMessageLabel.text = "Please enter a valid subreddit."
            return false
        }
        else {
            goButton.backgroundColor = UIColor( red: 0, green: 0.478, blue:1, alpha: 1.0 )
            errorMessageLabel.text = ""
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if
            let postsViewController = segue.destination as? PostsTableViewController,
            let subredditInput = subredditField.text
        {
            subredditURL = "https://www.reddit.com/r/\(subredditInput).json"
            postsViewController.subredditURL = subredditURL
        }
    }

}

