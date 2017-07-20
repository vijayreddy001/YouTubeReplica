//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Vijayanadk on 7/19/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    let blackView = UIView()
    let window = UIApplication.shared.keyWindow!
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    func showSettings() {
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        window.addSubview(blackView)
        blackView.frame = window.frame
        blackView.alpha = 0
        
        window.addSubview(collectionView)
        let height:CGFloat = 200
        let y = window.frame.height - height
        collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 200)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            
            self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            
        }, completion: nil)
        
        /*       UIView.animate(withDuration: 0.5, animations: {
                    self.blackView.alpha = 1
        
                    self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        
                })   */
        
    }
    
    func handleDismiss()
    {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: self.window.frame.height, width: self.window.frame.width, height: 200)
        }
    }
    override init() {
        super.init()
        
        
        
    }
    
}
