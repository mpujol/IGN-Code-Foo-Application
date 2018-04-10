//
//  FeedCell.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 4/7/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

class ArticleFeed: BaseCell ,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var contents: [Data]?
    
    var homeController: HomeController?
    
    
    let cellId = "cellId"
        
    func fetchContent() {
        
        ApiService.shared.fetchArticleFeed { (content: [Data]) in
            self.contents = content
            self.collectionView.reloadData()
        }
        
    }
    
    override func setupViews() {
        super.setupViews()
        
        fetchContent()
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ContentCell
        cell.content = contents?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let currentCell = collectionView.cellForItem(at: indexPath) as? ContentCell {
            
            if let metadata = currentCell.content?.metadata {
                print(metadata.slug)
            }
            
            
            if let url = URL(string: "http://www.ign.com/videos/2018/03/27/far-cry-5-walkthrough-story-mission-the-cleansing") {
                
                var webViewVC = ContentWebViewController()
                webViewVC.contentURL = url
                
                var topVC = UIApplication.shared.keyWindow?.rootViewController
                while((topVC!.presentedViewController) != nil) {
                    topVC = topVC!.presentedViewController
                }
                
                topVC?.present(webViewVC, animated: true, completion: nil)
                

                
            }
            
            
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: HomeController.Constants.colletionViewCellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
