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
    let sectionHeaderId = "sectionHeaderId"
    
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
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        
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
            
            if let content = currentCell.content {
                
                if let url = URL(string: Helper.getContentWebURLString(content: content)) {
                    print(Helper.getContentWebURLString(content: content))
                    let webViewVC = ContentWebViewController()
                    webViewVC.contentURL = url
                    
                    //Find the navigation controller in rootViewController to push the new content
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let rootVC = appDelegate.window?.rootViewController as? UINavigationController
                    rootVC?.pushViewController(webViewVC, animated: true)
                    
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath) as! HeaderCollectionReusableView
        return reusableView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height:36)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: HomeController.Constants.colletionViewCellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
