//
//  TrendingCell.swift
//  YouTube
//
//  Created by Vijayanadk on 7/24/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
      
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
