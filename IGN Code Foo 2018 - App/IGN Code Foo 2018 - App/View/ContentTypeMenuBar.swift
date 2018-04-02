//
//  ContentTypeMenuBar.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 4/1/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

class ContentTypeMenuBar: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        
        //add a drop shadow
        cv.layer.shadowColor = UIColor.black.cgColor
        cv.layer.shadowOffset = CGSize(width: 0, height: 3)
        cv.layer.shadowOpacity = 0.25
        cv.layer.shadowRadius = 2.0
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        
        return cv
    }()
    
    let cellId = "cellId"
    let imageNames = ["ContentTypeArticles","ContentTypeVideos"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(ContentTypeMenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        backgroundColor = UIColor.white
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
        
    }
    
    //MARK: - Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContentTypeMenuCell
        
        
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor(red: 188, green: 188, blue: 188)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ContentTypeMenuCell: BaseCell {
    
    let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ContentTypeArticles")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor(red: 188, green: 188, blue: 188)
        return imageView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor(red: 191, green: 19, blue: 19) : UIColor(red: 188, green: 188, blue: 188)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor(red: 191, green: 19, blue: 19) : UIColor(red: 188, green: 188, blue: 188)
        }
    }
    
        override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
            
        // Aspect Ratio
        addConstraints([NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: imageView, attribute: NSLayoutAttribute.width, multiplier: 120/457, constant: 0)])
            
        // Height & Width
        addConstraintsWithFormat(format: "V:|-13-[v0]-13-|", views: imageView)
            
        // centered
          addConstraints([NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)])
          addConstraints([NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)])
            
    }
    
}