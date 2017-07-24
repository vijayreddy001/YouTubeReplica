//
//  ApiService.swift
//  YouTube
//
//  Created by Vijayanadk on 7/22/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    //trailing closure implementation
    func fetchVideos(completion: @escaping ([Video]) ->()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) ->()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
        
    }
    func fetchSubscriptionFeed(completion: @escaping ([Video]) ->()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)    }
    
    func fetchFeedForUrlString(urlString:String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        let session = URLSession.shared // or let session = URLSession(configuration: URLSessionConfiguration.default)
        if let usableUrl = url {
            let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
                if let data = data {
                    //JSONSerialization
                    do {
                        let json = try JSONSerialization.jsonObject(with: data)
                        var videos = [Video]()
                        for dictionary in json as! [[String: Any]] {
                            let video = Video()
                            video.title = dictionary["title"] as? String
                            video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                            let channelItems = dictionary["channel"] as! [String:Any]
                            let channel = Channel()
                            channel.name = channelItems["name"] as? String
                            channel.profileImageName = channelItems["profile_image_name"] as? String
                            video.channel = channel
                            videos.append(video)
                        }
                        DispatchQueue.main.async {
                            completion(videos)
                        }
                    } catch {
                        print(error)
                    }
                }
            })
            task.resume()
        }
    }
    
}
