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

    var contents: [Data]?

    func fetchContent() {
        
        guard let url = URL(string: "https://ign-apis.herokuapp.com/content?count=20") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let data = data {
                do {
                    let feed = try JSONDecoder().decode(Feed.self, from: data)
                    
                    
                    self.contents = [Data]()
                    
                    print(feed.count)
                    for content in feed.data {
                        self.contents?.append(content)
                        print(content.metadata.publishDate)
                    }
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                } catch let jsonError {
                    print(jsonError)
                }
            }
            
            if let err = err {
                print(err.localizedDescription)
            }
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
       
        fetchContent()
        
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
        return contents?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ContentCell
        
        cell.content = contents?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: Constants.colletionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}


