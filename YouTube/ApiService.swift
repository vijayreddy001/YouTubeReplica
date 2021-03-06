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
               
                if error != nil {
                    print(error!)
                    return
                }
                  //JSONSerialization
                    do {
                        if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData) as? [[String:Any]] {
                                DispatchQueue.main.async {
                                    completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                                }
                            }
                        
                    } catch {
                        print(error)
                    }
                
            })
            task.resume()
        }
    }
    
}


//let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
//
//var videos = [Video]()
//
//for dictionary in json as! [[String: AnyObject]] {
//
//    let video = Video()
//    video.title = dictionary["title"] as? String
//    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//
//    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//
//    let channel = Channel()
//    channel.name = channelDictionary["name"] as? String
//    channel.profileImageName = channelDictionary["profile_image_name"] as? String
//
//    video.channel = channel
//
//    videos.append(video)
//}
//
//dispatch_async(dispatch_get_main_queue(), {
//    completion(videos)
//})




//                    let numbersArray = [1, 2, 3]
//                    let doubledNumbersArray = numbersArray.map({return $0 * 2})
//                    let stringsArray = numbersArray.map({return "\($0 * 2)"})
//                    print(stringsArray)

//                    var videos = [Video]()
//
//                    for dictionary in jsonDictionaries {
//                        let video = Video(dictionary: dictionary)
//                        videos.append(video)
//                    }

