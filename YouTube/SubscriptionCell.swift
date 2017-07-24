//
//  SubscriptionCell.swift
//  YouTube
//
//  Created by Vijayanadk on 7/24/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
ApiService.sharedInstance.fetchSubscriptionFeed { (videos12) in
    self.videos = videos12
    self.collectionView.reloadData()
        }
    }
}
