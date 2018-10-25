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
        cv.refreshControl = UIRefreshControl()
        cv.refreshControl?.layer.zPosition = -1
        cv.refreshControl?.tintColor = UIColor(red: 191, green: 19, blue: 19)
        cv.refreshControl?.addTarget(self, action: #selector(self.reloadContent), for: .valueChanged)
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    var contents: [Data]?
    var currentStartIndex: Int = 0
    var homeController: HomeController?
    
    let cellId = "cellId"
    let sectionHeaderId = "sectionHeaderId"
    
    func fetchFeed() {

        ApiService.shared.fetchArticleFeedAt(startIndex: currentStartIndex) { (content:[Data]) in
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
    
    @objc func reloadContent() {
        self.currentStartIndex = 0
        self.contents = nil
        fetchFeed()
        stopRefreshControl()
    }
    
    func stopRefreshControl() {
        self.collectionView.refreshControl?.endRefreshing()
    }
    
    override func setupViews() {
        super.setupViews()
        fetchFeed()
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ContentCell
        cell.content = contents?[indexPath.item]
        cell.openContentButton.addTarget(self, action: #selector(didSelectOpenContentButtonfor(sender:)), for: UIControl.Event.touchUpInside)
        cell.openContentButton.tag = indexPath.item
        if let contentCount = self.contents?.count {
            if indexPath.item == contentCount - 1 {
                self.fetchFeed()
            }
        }
        return cell
    }
    
    @objc func didSelectOpenContentButtonfor(sender:UIButton) {
        let buttonTag = sender.tag
        if let content = contents?[buttonTag] {
            Helper.openWebViewFor(content: content)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let currentCell = collectionView.cellForItem(at: indexPath) as? ContentCell {
            if let content = currentCell.content {
                    Helper.openWebViewFor(content: content)
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


