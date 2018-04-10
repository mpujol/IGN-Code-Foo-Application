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

    let articleCellId = "articleCellId"
    let videoCellId = "videoCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
       
        
        
        setupContentTypeMenuBar()
        setupCollectionView()
        
    }
    
    lazy var contentTypeMenuBar: ContentTypeMenuBar = {
        let menuBar = ContentTypeMenuBar()
        menuBar.homeController = self
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(ArticleFeed.self, forCellWithReuseIdentifier: articleCellId)
        collectionView?.register(VideoFeed.self, forCellWithReuseIdentifier: videoCellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
        
    }
    
    
    private func setupContentTypeMenuBar() {
        view.addSubview(contentTypeMenuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: contentTypeMenuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: contentTypeMenuBar)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath , at: [], animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var identifier: String = ""
        
        if indexPath.item == 0 {
            identifier = articleCellId
        } else if indexPath.item == 1 {
            identifier = videoCellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentTypeMenuBar.horizontalMenuBarLeftAnchorContraint?.constant = (scrollView.contentOffset.x / 2) + ContentTypeMenuBar.Constants.HorizontalMenuBarLeftOffset
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x/view.frame.width
        let indexPath = IndexPath(row: Int(index), section: 0)
        contentTypeMenuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
       
    }
    
}


