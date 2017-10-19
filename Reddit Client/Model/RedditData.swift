//
//  RedditData.swift
//  Reddit Client
//
//  Created by Jonathan Chua on 10/12/17.
//  Copyright © 2017 Jonathan Chua. All rights reserved.
//

import Foundation

struct RedditData: Codable {
    struct Data: Codable {
        struct Children: Codable {
            struct PostData: Codable {
                let selftext: String
                let title: String
                let url: String
                let author: String
            }
            
            let data: PostData
        }
        
        let children: [Children]
    }
    
    let data: Data
}
