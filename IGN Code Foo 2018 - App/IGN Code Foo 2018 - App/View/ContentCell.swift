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
        
    var content: Data? {
        didSet {
            if let content = content {
                titleTextView.text = content.metadata.title
                subtitleTextView.text = content.metadata.description
                
                //format or calculate publish date label
                let publishDateString = content.metadata.publishDate
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                
                let todaysDate = Date()
                
                if let publishDate = dateFormatter.date(from: publishDateString) {
                    if todaysDate.hours(from: publishDate) > 24 {
                        dateFormatter.dateStyle = .long
                        publishDateLabel.text = dateFormatter.string(from: publishDate)
                    } else {
                        publishDateLabel.text = todaysDate.offset(from: publishDate)
                    }
                }
                
                switch content.metadata.contentType {
                case "article":
                    openContentButton.setImage(UIImage(named: "Read")?.withRenderingMode(.alwaysTemplate), for: UIControl.State.normal)
                    playButtonImageView.isHidden = true
                case "video":
                    openContentButton.setImage(UIImage(named: "Watch")?.withRenderingMode(.alwaysTemplate), for: UIControl.State.normal) 
                default:
                    break
                }
                setupThumbnailImage()
                setupViewLabel()
            }
        }
    }
    
    struct Constants {
        static let publishLabelFontSize: CGFloat = 12
        static let titleTextViewFontSize: CGFloat = 22
        static let commentCountLabelFontSize: CGFloat = 14
        static let descriptionTextViewFontSize: CGFloat = 12
        static let sidePadding = 16
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = content?.thumbnails.last?.url {
            thumbnailImageView.loadImageUsingURLString(urlString: thumbnailImageUrl)
        }
    }
    
    func setupViewLabel() {
        if let contentId = content?.contentId {
            ApiService.shared.loadNumberOfViewsForContentID(contentID: contentId, completion: { (commentCount: String) in
                self.commentCountLabel.text = commentCount
            })
        }
    }
    
    let publishDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 191, green: 32, blue: 38)
        label.text = "12 MIN AGO"
        label.font = .systemFont(ofSize: Constants.publishLabelFontSize, weight: UIFont.Weight.black)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        textView.text = "Venom's 30th Anniversary Celebrated With Special Variant Covers"
        textView.textColor = UIColor.black
        textView.font = .systemFont(ofSize: Constants.titleTextViewFontSize, weight: UIFont.Weight.black)
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.textContainerInset = UIEdgeInsets.zero
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
        
        return textView
    }()
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "Venom")
        imageView.backgroundColor = UIColor.lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let playButtonImageView:UIImageView = {
        let image = UIImage(named: "PlayButton")
        let iv = UIImageView(image: image)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        textView.text = "Marvel is celebrating Venom's 30th anniversary with special variant comic book covers."
        textView.textColor = UIColor(red: 159, green: 159, blue: 159)
        textView.font = .systemFont(ofSize: Constants.descriptionTextViewFontSize, weight: UIFont.Weight.medium)
        textView.isUserInteractionEnabled = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    let openContentButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Read")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: UIControl.State.normal)
        button.tintColor = UIColor(red: 193, green: 194, blue: 199)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let commentButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Comment")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: UIControl.State.normal)
        button.tintColor = UIColor(red: 193, green: 194, blue: 199)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let commentCountLabel:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: Constants.commentCountLabelFontSize, weight: UIFont.Weight.medium)
        label.textColor = UIColor(red: 53, green: 137, blue: 181)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 195, green: 195, blue: 195)
        
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
        
        thumbnailImageView.addSubview(playButtonImageView)

        thumbnailImageView.addConstraint(NSLayoutConstraint(item: playButtonImageView, attribute: .centerX, relatedBy: .equal, toItem: thumbnailImageView, attribute: .centerX, multiplier: 1, constant: 0))
        thumbnailImageView.addConstraint(NSLayoutConstraint(item: playButtonImageView, attribute: .centerY, relatedBy: .equal, toItem: thumbnailImageView, attribute: .centerY, multiplier: 1, constant: 0))
        thumbnailImageView.addConstraint(NSLayoutConstraint(item: playButtonImageView, attribute: .height, relatedBy: .equal, toItem: thumbnailImageView, attribute: .height, multiplier: 0.4, constant: 0))
        
        thumbnailImageView.addConstraint(NSLayoutConstraint(item: playButtonImageView, attribute: .height, relatedBy: .equal, toItem: playButtonImageView, attribute: .width, multiplier: 1, constant: 0))
        
        
        backgroundColor = .white

        //Thumbnail Aspect Ratio constraint
        addConstraints([NSLayoutConstraint(item: thumbnailImageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: thumbnailImageView, attribute: NSLayoutConstraint.Attribute.width, multiplier: (9/16), constant: 0)])

        //openContentButton Aspect Ratio Constraint
        addConstraints([NSLayoutConstraint(item: openContentButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: openContentButton, attribute: NSLayoutConstraint.Attribute.width, multiplier: (120/457), constant: 0)])

        //commentButton Aspect Ratio Contraint
        addConstraints([NSLayoutConstraint(item: commentButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: commentButton, attribute: NSLayoutConstraint.Attribute.width, multiplier: (120/457), constant: 0)])

        //commmentButton height constraint
        addConstraints([NSLayoutConstraint(item: commentButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: openContentButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)])

        //commentButton vertical location
        addConstraints([NSLayoutConstraint(item: commentButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: openContentButton, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: commentButton, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: openContentButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)])

        //commentCountLabel vertical Location
        addConstraints([NSLayoutConstraint(item: commentCountLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: openContentButton, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: commentCountLabel, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: openContentButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)])

        addConstraints([NSLayoutConstraint(item: openContentButton, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: commentButton, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)])

        //Vertical Constraints
        addConstraintsWithFormat(format: "V:|-28-[v0(10)][v1]-[v2]-6-[v3]-[v4(25)]-[v5(1)]|", views: publishDateLabel,titleTextView, thumbnailImageView, subtitleTextView, openContentButton,separatorView)

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
