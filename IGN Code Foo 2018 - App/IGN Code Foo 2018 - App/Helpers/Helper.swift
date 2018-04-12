//
//  Helper.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 4/11/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import Foundation

class Helper {
    static func getContentWebURLString(content: Data) -> String {
        
        let baseURLString = "http://www.ign.com/"
        
        let publishDateString = content.metadata.publishDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let contentString = "\(content.metadata.contentType)s/"
        
        var dateString = ""
        
        if let publishDate = dateFormatter.date(from: publishDateString) {
            
            dateString = "\(publishDate.year)/\(publishDate.month)/\(publishDate.day)/"
            
        }
        
        
        return "\(baseURLString)\(contentString)\(dateString)\(content.metadata.slug)"
    }
}
