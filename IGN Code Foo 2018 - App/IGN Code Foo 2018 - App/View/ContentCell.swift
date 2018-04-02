//
//  ContentCell.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 3/30/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ContentCell: BaseCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupviews()
    }
    
    struct Constants {
        static let publishLabelFontSize: CGFloat = 11
        static let titleTextViewFontSize: CGFloat = 20
        static let descriptionTextViewFontSize: CGFloat = 12
        static let sidePadding = 16
    }
    
    let publishDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 191, green: 32, blue: 38)
        label.text = "12 MIN AGO"
        label.font = .systemFont(ofSize: Constants.publishLabelFontSize, weight: UIFont.Weight.black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Venom's 30th Anniversary Celebrated With Special Variant Covers"
        textView.textColor = UIColor.black
        textView.font = .systemFont(ofSize: Constants.titleTextViewFontSize, weight: UIFont.Weight.black)
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.textContainerInset = UIEdgeInsets.zero
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
        textView.textColor = UIColor(red: 159, green: 159, blue: 159)
        textView.font = .systemFont(ofSize: Constants.descriptionTextViewFontSize, weight: UIFont.Weight.medium)
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let openContentButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Read")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: UIControlState.normal)
        button.tintColor = UIColor(red: 193, green: 194, blue: 199)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Comment")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: UIControlState.normal)
        button.tintColor = UIColor(red: 193, green: 194, blue: 199)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let commentCountLabel:UILabel = {
        let label = UILabel()
        label.text = "24"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(openContentButton)
        addSubview(commentButton)
        addSubview(commentCountLabel)
        
        
        //Thumbnail Aspect Ratio constraint
        addConstraints([NSLayoutConstraint(item: thumbnailImageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: thumbnailImageView, attribute: NSLayoutAttribute.width, multiplier: (9/16), constant: 0)])
        
        //openContentButton Aspect Ratio Constraint
        addConstraints([NSLayoutConstraint(item: openContentButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: openContentButton, attribute: NSLayoutAttribute.width, multiplier: (120/457), constant: 0)])
        
        //commentButton Aspect Ratio Contraint
        addConstraints([NSLayoutConstraint(item: commentButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: commentButton, attribute: NSLayoutAttribute.width, multiplier: (120/457), constant: 0)])
        
        //commmentButton height constraint
        addConstraints([NSLayoutConstraint(item: commentButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: openContentButton, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)])
        
        //commentButton vertical location
        addConstraints([NSLayoutConstraint(item: commentButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: openContentButton, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: commentButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: openContentButton, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)])
        
        //commentCountLabel vertical Location
        addConstraints([NSLayoutConstraint(item: commentCountLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: openContentButton, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: commentCountLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: openContentButton, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)])
        
        addConstraints([NSLayoutConstraint(item: openContentButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.lessThanOrEqual, toItem: commentButton, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)])
        
        
        //Vertical Constraints
        addConstraintsWithFormat(format: "V:|-28-[v0][v1]-[v2]-6-[v3]-[v4(25)]-[v5(1)]|", views: publishDateLabel,titleTextView, thumbnailImageView, subtitleTextView, openContentButton,separatorView)
        
        //Horizontal contraints
        addConstraintsWithFormat(format: "H:|-\(Constants.sidePadding)-[v0]-\(Constants.sidePadding)-|", views: publishDateLabel)
        addConstraintsWithFormat(format: "H:|-\(Constants.sidePadding)-[v0]-\(Constants.sidePadding)-|", views: titleTextView)
        addConstraintsWithFormat(format: "H:|-\(Constants.sidePadding)-[v0]-\(Constants.sidePadding)-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-\(Constants.sidePadding)-[v0]-\(Constants.sidePadding)-|", views: subtitleTextView)
        addConstraintsWithFormat(format: "H:|-\(Constants.sidePadding)-[v0]-\(Constants.sidePadding)-|", views: separatorView)
        addConstraintsWithFormat(format: "H:|-\(Constants.sidePadding)-[v0]", views: openContentButton)
        addConstraintsWithFormat(format: "H:[v0]-[v1]-\(Constants.sidePadding)-|", views: commentButton,commentCountLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(cover:) has not been implemented")
    }
}
