//
//  Video.swift
//  YouTube
//
//  Created by Vijayanadk on 7/17/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnail_image_name: String?
    var title: String?
    var channel: Channel?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration:NSNumber?
 
    override func setValue(_ value: Any?, forKey key: String) {
        
            if key == "channel" {
             self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String:Any])
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
    
    //ovveride vs super.init()

    init(dictionary: [String:Any]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

class Channel: NSObject {
    var name: String?
    var profile_image_name: String?
}

