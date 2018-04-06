//
//  Content.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 3/24/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

struct Feed: Decodable {
    let count: Int
    let startIndex: Int
    let data: [Data]
    }

struct Data: Decodable {
    let contentId:String
    let thumbnails: [Thumbnail]
    let metadata: Metadata
    let tags: [String]
}

struct Metadata: Decodable {
    let contentType: String
    let title: String
    let description: String
    let publishDate: String
    let slug: String
    let networks: [String]
    let state: String
}

struct Thumbnail: Decodable {
    let url:String
    let size: String
    let width: Int
    let height: Int
}

struct Comment: Decodable {
    let count: Int
    let content: [commentMetadata]
}

struct commentMetadata: Decodable {
    let id: String
    let commentCount: Int
    
    enum CodingKeys: CodingKey,String {
        case id
        case commentCount = "count"
    }
}
