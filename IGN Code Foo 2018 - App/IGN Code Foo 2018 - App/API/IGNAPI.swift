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
        static let content = "https://ign-apis.herokuapp.com/content"
        static let comments = "https://ign-apis.herokuapp.com/comments"
        static let defaultContentCount:Int = 20
    }
    
    func fetchArticleFeedAt(startIndex: Int, completion: @escaping ([Data]) -> ()) {
        fetchContent(type: "article",startIndex: startIndex) { (content) in
            completion(content)
        }
    }
    
    func fetchVideoFeedAt(StartIndex: Int, completion: @escaping ([Data]) -> ()) {
        fetchContent(type: "video", startIndex: StartIndex) { (content) in
        completion(content)
        }
    }
    
    func loadNumberOfViewsForContentID(contentID: String, completion: @escaping (String) -> ()) {
        
        guard let baseURL = URL(string: URLFeed.comments) else { return }
        
        let query: [String: String] = ["ids":"\(contentID)"]
        
        guard let url = baseURL.withQueries(query) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let data = data {
                do {
                    let comment = try JSONDecoder().decode(Comment.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion("\(comment.content.last?.commentCount ?? 0)")
                        
                    }
                    
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
            
            if let err = err {
                print(err.localizedDescription)
            }
            }.resume()
        }
    
    func fetchContent(type: String, startIndex:Int, completion: @escaping ([Data]) -> ()) {
        
        guard let baseURL = URL(string: URLFeed.content) else { return }
        
        let query: [String: String] = ["startIndex":"\(startIndex)","count":"\(URLFeed.defaultContentCount)"]
        
        guard let url = baseURL.withQueries(query) else { return }
        
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
                    print("Found JSON Error:\(jsonError)")
                }
            }
            if let err = err {
                print(err.localizedDescription)
            }
        }.resume()
    }
}
    

