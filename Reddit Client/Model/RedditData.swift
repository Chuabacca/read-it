//
//  RedditData.swift
//  Reddit Client
//
//  Created by Jonathan Chua on 10/12/17.
//  Copyright © 2017 Jonathan Chua. All rights reserved.
//

import Foundation

class RedditPost: Codable {
    var title: String
    var author: String
    var selftext: String
    var url: String
    var comments: Int
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case selftext
        case url
        case comments = "num_comments"
    }
}

