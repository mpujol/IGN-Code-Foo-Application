//
//  Extentions.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 3/24/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String:UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date)) YEARS AGO"   }
        if months(from: date)  > 0 { return "\(months(from: date)) MONTHS AGO"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date)) WEEKS AGO"   }
        if days(from: date)    > 0 { return "\(days(from: date)) DAYS AGO"    }
        if hours(from: date)   > 0 { return "\(hours(from: date)) HOURS AGO"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date)) MINUTES AGO" }
        if seconds(from: date) > 0 { return "\(seconds(from: date)) SECONDS AGO" }
        return ""
    }
    //for the formatting of the contentURL in UIWebView
    var year: String  { return Formatter.year.string(from: self) }
    var month:  String      { return Formatter.month.string(from: self) }
    var day: String     { return Formatter.day.string(from: self) }
}

extension Formatter {
    static let year: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "y"
        return formatter
    }()
    
    static let month: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter
    }()

    static let day: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingURLString(urlString: String) {
       
        imageUrlString = urlString
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if err != nil {
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let imageToCache = UIImage(data: data) {
                            
                            if self.imageUrlString == urlString {
                                self.image = imageToCache
                            }
                            imageCache.setObject(imageToCache, forKey: urlString as NSString)
                        }
                    }
                }
            }.resume()
        }
    }
}

extension URL {
    func withQueries(_ queries:[String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
            return components?.url
    }
}

