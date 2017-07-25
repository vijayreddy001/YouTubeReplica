//
//  File.swift
//  YouTube
//
//  Created by Vijayanadk on 7/17/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

extension UIColor
{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) ->UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format:String, views:UIView...) {
        var viewDictionaries = [String:UIView]()
        for (index,view) in views.enumerated(){
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionaries["v\(index)"] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionaries))
        //            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":thumbNailImageView]))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class customImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        imageUrlString = urlString
        let url = URL(string: urlString)
        
        image = nil
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = cachedImage
            return
        }
        
        let session = URLSession.shared // or let session = URLSession(configuration: URLSessionConfiguration.default)
        if let usableUrl = url {
            let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    let imageToChache = UIImage(data: data!)
                    //                if self.imageUrlString == urlString {
                    //                    self.image = imageToChache
                    //                }
                    self.image = imageToChache
                    
                    imageCache.setObject(imageToChache!, forKey: urlString as AnyObject)
                }
                
                
            })
            
            task.resume()
        }
    }
    
}
