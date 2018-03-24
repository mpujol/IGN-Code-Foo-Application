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
    
    private enum URLFeed: String {
        case content = "https://ign-apis.herokuapp.com/content"
        case comments = "https://ign-apis.herokuapp.com/comments"
    }
    
    func fetchContent() {
        
        guard let url = URL(string: URLFeed.content.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let data = data {
                do {
                    let feed = try JSONDecoder().decode(Feed.self, from: data)
                    
                    print(feed.count)
                    for content in feed.data {
                        print(content.metadata.title)
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
