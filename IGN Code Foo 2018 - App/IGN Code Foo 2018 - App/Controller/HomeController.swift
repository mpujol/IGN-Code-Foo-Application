//
//  HomeController.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 3/24/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    struct Constants {
        static let colletionViewCellHeight:CGFloat = 450
    
    }

    var contents: [Data] = {
        
        let sampleThumbnail1 = Thumbnail(url: "https://assets1.ignimgs.com/2017/07/26/fortnite-1280thumb02-1501031574305_large.jpg",
                                        size: "large", width: 626, height: 352)
        let sampleMetadata1 = Metadata(contentType: "article",
                                      title: "Fortnite Topped iOS Charts in 47 Countries Less Than 24 Hours After Launch",
                                      description: "Epic Games' battle royale title tops the iOS charts in almost 50 countries.",
                                      publishDate: "2018-03-19T16:09:41+0000",
                                      slug: "fortnite-topped-ios-charts-in-47-countries-less-than-24-hours-after-launch",
                                      networks: ["IGN"],
                                      state: "published")
        let sampleData1 = Data(contentId: "5aafdc3ce4b011ed899910bf", thumbnails: [sampleThumbnail1], metadata: sampleMetadata1, tags: [""])
        
        let sampleThumbnail2 = Thumbnail(url: "https://assets1.ignimgs.com/2018/03/17/infinitywar-rewind-1280-1521307093697_large.jpg",
                                         size: "large", width: 626, height: 352)
        let sampleMetadata2 = Metadata(contentType: "article",
                                       title: "Avengers: Infinity War Trailer Breakdown - Details You Might Have Missed",
                                       description: "The Avengers are back in the latest Infinity War trailer, so IGN’s Marvel experts have assembled to break down all the details frame by frame.",
                                       publishDate: "2018-03-19T16:07:23+0000",
                                       slug: "avengers-infinity-war-trailer-breakdown-details-you-might-have-missed-2",
                                       networks: ["IGN"],
                                       state: "published")
        let sampleData2 = Data(contentId: "5aad4ddee4b0d178e9f0d387", thumbnails: [sampleThumbnail2], metadata: sampleMetadata2, tags: [""])
        
        return [sampleData1,sampleData2]
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
       
        setupContentTypeMenuBar()
        setupCollectionView()
        
    }
    
    let contentTypeMenuBar: ContentTypeMenuBar = {
        let menuBar = ContentTypeMenuBar()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    
    
    func setupCollectionView() {
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(ContentCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
    }
    
    
    private func setupContentTypeMenuBar() {
        view.addSubview(contentTypeMenuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: contentTypeMenuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: contentTypeMenuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ContentCell
        
        cell.content = contents[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: Constants.colletionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}


