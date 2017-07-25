//
//  VideoCell.swift
//  YouTube
//
//  Created by Vijayanadk on 7/17/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

class BaseCell : UICollectionViewCell {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        
    }
}


class VideoCell : BaseCell
{
    var video : Video? {
        didSet{
            titleLable.text = video?.title
            
            setupThumbnailImage()
            setupProfileImage()
            
            //            if let profileImageName = video?.channel?.profileImageName {
            //                userProfileImageView.image = UIImage(named: profileImageName)
            //            }
            //
            if let channelName = video?.channel?.name, let numberofViews = video?.number_of_views {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let subtitleText = "\(channelName) * \(numberFormatter.string(from: numberofViews)!) * 2 years ago"
                subtitleTextView.text = subtitleText
            }
            
            //Measure the title text
            if let title = video?.title {
                let size = CGSize(width: frame.width-16-44-8-16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                if estimatedRect.size.height > 20 {
                    titleLableHeightConstraint?.constant = 44
                    
                }
                else {
                    titleLableHeightConstraint?.constant = 20
                }
            }
            
        }
    }
    
    func setupProfileImage() {
        if let profileImageName = video?.channel?.profile_image_name {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageName)
        }
        
        
    }
    func setupThumbnailImage() {
        if let thumbnailImageName = video?.thumbnail_image_name {
            thumbNailImageView.loadImageUsingUrlString(urlString: thumbnailImageName)
        }
    }
    
    let thumbNailImageView : customImageView = {
        var imageView = customImageView()
        imageView.image = UIImage(named:"taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let seperatorView : UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return separatorView
    }()
    let userProfileImageView : customImageView = {
        var profileImage = customImageView()
        profileImage.image = UIImage(named: "swift_profile_image")
        profileImage.contentMode = .scaleAspectFill
        return profileImage
    }()
    let titleLable : UILabel = {
        var titleLable = UILabel()
        titleLable.text = "Taylor swift blank space"
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.numberOfLines = 2
        return titleLable
    }()
    let subtitleTextView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO - 1,646,070 000, views . 2 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    var titleLableHeightConstraint: NSLayoutConstraint?
    
    
    override func setupViews(){
        self.addSubview(thumbNailImageView)
        self.addSubview(seperatorView)
        self.addSubview(userProfileImageView)
        self.addSubview(titleLable)
        self.addSubview(subtitleTextView)
        
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbNailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbNailImageView,userProfileImageView,seperatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLable, attribute: .top, relatedBy: .equal, toItem: thumbNailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLable, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLable, attribute: .right, relatedBy: .equal, toItem: thumbNailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        titleLableHeightConstraint = NSLayoutConstraint(item: titleLable, attribute: .height, relatedBy: .equal, toItem: self, attribute:.height, multiplier: 0, constant: 44)
        addConstraint(titleLableHeightConstraint!)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLable, attribute: .bottom, multiplier: 1, constant: 4))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbNailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute:.height, multiplier: 0, constant: 30))
        
    }
}




