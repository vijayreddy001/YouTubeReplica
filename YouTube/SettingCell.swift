//
//  SettingCell.swift
//  YouTube
//
//  Created by Vijayanadk on 7/20/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

class Setting {
    let name: String
    let imageName: String
    
    init(name:String, imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}
class SettingCell: BaseCell {
  
    override var isHighlighted: Bool {
        didSet {
        backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
        label.textColor = isHighlighted ? UIColor.white : UIColor.black
        iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
    }
}

    var settingItems:Setting? {
        didSet {
            label.text = settingItems?.name
            if let imageName = settingItems?.imageName
            {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    let label: UILabel = {
        
        let label = UILabel()
        //label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        //iconImageView.image = UIImage(named: "settings")
        return iconImageView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(label)
        addSubview(iconImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView,label)
        addConstraintsWithFormat(format: "V:|[v0]|", views: label)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
       addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
