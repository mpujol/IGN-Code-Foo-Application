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
        static let colletionViewCellHeight:CGFloat = 435
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.title = "IGN"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ContentCell.self, forCellWithReuseIdentifier: "cellId")
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: Constants.colletionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

class ContentCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupviews()
    }
    
    struct Constants {
        static let publishLabelFontSize: CGFloat = 12
        static let titleTextViewFontSize: CGFloat = 22
        static let descriptionTextViewFontSize: CGFloat = 14
    }
    
    let publishDateLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.red
        label.text = "12 MIN AGO"
        label.font = .systemFont(ofSize: Constants.publishLabelFontSize, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Venom's 30th Anniversary Celebrated With Special Variant Covers"
        textView.textColor = UIColor.black
        textView.font = .systemFont(ofSize: Constants.titleTextViewFontSize, weight: UIFont.Weight.heavy)
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets.zero
        textView.isSelectable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.vertical)
        return textView
    }()
    
    let thumbnailImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Venom")
        imageView.backgroundColor = UIColor.lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Marvel is celebrating Venom's 30th anniversary with special variant comic book covers."
        textView.textColor = UIColor.lightGray
        textView.font = .systemFont(ofSize: Constants.descriptionTextViewFontSize)
        textView.isSelectable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupviews() {
        addSubview(publishDateLabel)
        addSubview(titleTextView)
        addSubview(thumbnailImageView)
        addSubview(subtitleTextView)
        addSubview(separatorView)
        
        
        //Thumbnail Aspect Ratio constraint
        addConstraints([NSLayoutConstraint(item: thumbnailImageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: thumbnailImageView, attribute: NSLayoutAttribute.width, multiplier: (9/16), constant: 0)])
        
        //Vertical Constraints
        addConstraintsWithFormat(format: "V:|-28-[v0][v1]-[v2]-[v3]-[v4(1)]|", views: publishDateLabel,titleTextView, thumbnailImageView, subtitleTextView,separatorView)
        
        //Horizontal contraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: publishDateLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: titleTextView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: subtitleTextView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: separatorView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(cover:) has not been implemented")
    }
}
