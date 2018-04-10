//
//  IGNAPI.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 3/24/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import Foundation

class ApiService: NSObject {
    
    static var shared = ApiService()
    
    struct URLFeed {
        static let content = "https://ign-apis.herokuapp.com/content?count=20"
        static let comments = "https://ign-apis.herokuapp.com/comments"
    }
    
    func fetchArticleFeed(completion: @escaping ([Data]) -> ()) {
        fetchContent(type: "article") { (content) in
            completion(content)
        }
    }
    
    func fetchVideoFeed(completion: @escaping ([Data]) -> ()) {
        fetchContent(type: "video") { (content) in
        completion(content)
    }
    }
    
    func fetchContent(type: String, completion: @escaping ([Data]) -> ()) {
        
        guard let url = URL(string: URLFeed.content) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let data = data {
                do {
                    let feed = try JSONDecoder().decode(Feed.self, from: data)
                    var contents = [Data]()
                    for content in feed.data {
                        if content.metadata.contentType == type {
                            contents.append(content)
                            
                        }
                    }
                    DispatchQueue.main.async {
                        completion(contents)
                    }
                } catch let jsonError {
                    print(jsonError)
                }
            }
            
            if let err = err {
                print(err.localizedDescription)
            }
            
            }.resume()
    }
    
}
