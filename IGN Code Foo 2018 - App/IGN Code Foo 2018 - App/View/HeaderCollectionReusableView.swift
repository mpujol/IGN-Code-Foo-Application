//
//  HeaderCollectionReusableView.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 4/11/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let sectionHeaderImageView:UIImageView = {
       let iv = UIImageView(image: UIImage(named: "SectionHeader"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 195, green: 195, blue: 195)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews() {
        
        addSubview(sectionHeaderImageView)
        addSubview(separatorView)
        backgroundColor = .white
        addConstraintsWithFormat(format: "V:|[v0][v1(1)]|", views: sectionHeaderImageView,separatorView)
        addConstraintsWithFormat(format: "H:|-\(ContentCell.Constants.sidePadding)-[v0]-\(ContentCell.Constants.sidePadding)-|", views: separatorView)
        
        addConstraint(NSLayoutConstraint(item: sectionHeaderImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: sectionHeaderImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.6, constant: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
