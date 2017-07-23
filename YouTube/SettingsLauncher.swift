//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Vijayanadk on 7/19/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

class Setting {
    let name: SettingName
    let imageName: String
    
    init(name:String, imageName:String) {
        self.name = SettingName(rawValue: name)!
        self.imageName = imageName
    }
}
enum SettingName: String {
    case Settings = "Settings"
    case TermsPrivacy = "Terms & privacy policy"
    case SendFeedback = "Send feedback"
    case Help = "Help"
    case SwichAccount = "Switch Account"
    case Cancel = "Cancel"
    }
class SettingsLauncher: NSObject, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    let window = UIApplication.shared.keyWindow!
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    let settings: [Setting] = {
        
        let settingSetting = Setting(name: SettingName.Settings.rawValue, imageName: "settings")
        let termsSetting = Setting(name: SettingName.TermsPrivacy.rawValue, imageName: "privacy")
        let feedbackSetting = Setting(name: SettingName.SendFeedback.rawValue,imageName: "feedback")
        let helpSetting = Setting(name: SettingName.Help.rawValue,imageName: "help")
        let switchSetting = Setting(name: SettingName.SwichAccount.rawValue,imageName: "switch_account")
        let cancelSetting = Setting(name: SettingName.Cancel.rawValue,imageName: "cancel")
        return [settingSetting,termsSetting,feedbackSetting,helpSetting,switchSetting,cancelSetting]
    }()
    
    var homecontroller: HomeViewController?
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    func showSettings() {
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        window.addSubview(blackView)
        blackView.frame = window.frame
        blackView.alpha = 0
        
        window.addSubview(collectionView)
        let height:CGFloat = CGFloat(settings.count) * cellHeight
        let y = window.frame.height - height
        collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            
            self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            
        }, completion: nil)
    
    }
    
    func handleDismiss()
    {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: self.window.frame.height, width: self.window.frame.width, height: 200)
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.settingItems = settings[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        handleDismiss()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: self.window.frame.height, width: self.window.frame.width, height: 200)
        }) { (Bool) in
           
            let setting = self.settings[indexPath.item]
            if setting.name != .Cancel {
            self.homecontroller?.showControllerForSettings(setting: setting)
            }
            
        }
   }
   }
