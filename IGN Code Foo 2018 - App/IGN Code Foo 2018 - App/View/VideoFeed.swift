//
//  VideoCell.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 4/9/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

class VideoFeed: ArticleFeed {
    
    override func fetchFeed() {
        
        ApiService.shared.fetchVideoFeedAt(StartIndex: currentStartIndex) { (content:[Data]) in
            if self.contents == nil {
                self.contents = content
            } else {
                for singleContent in content {
                    self.contents?.append(singleContent)
                }
            }
            self.collectionView.reloadData()
            self.currentStartIndex += ApiService.URLFeed.defaultContentCount
        }
        
    }
}
