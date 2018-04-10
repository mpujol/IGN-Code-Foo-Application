//
//  VideoCell.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 4/9/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

class VideoFeed: ArticleFeed {

    override func fetchContent() {
        
        ApiService.shared.fetchVideoFeed { (content: [Data]) in
            self.contents = content
            self.collectionView.reloadData()
        }
        
    }
    
}
