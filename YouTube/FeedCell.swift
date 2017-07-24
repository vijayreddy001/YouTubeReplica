//
//  FeedCell.swift
//  YouTube
//
//  Created by Vijayanadk on 7/23/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var videos: [Video]?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    func fetchVideos() {
        
        //trailing closure implementation
        ApiService.sharedInstance.fetchVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
            }
    }

    override func setupViews() {
        super.setupViews()
        fetchVideos()
        backgroundColor = UIColor.brown
       addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")

    }
    
         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return videos?.count ?? 0
        }
    
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cellId", for: indexPath) as! VideoCell
            cell.video = videos?[indexPath.item]
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let height = (frame.width-16-16) * 9/16
            return CGSize(width:frame.width, height:height+16+88)
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

}
