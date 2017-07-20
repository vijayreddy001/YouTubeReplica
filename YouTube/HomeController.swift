//
//  ViewController.swift
//  YouTube
//
//  Created by Vijayanadk on 7/14/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //navigationItem.title = "Home"
        let titleView = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleView.textColor = UIColor.white
        titleView.text = "Home"
        titleView.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleView
        navigationController?.navigationBar.isTranslucent = false
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        setupMenuBar()
        setupNavBarButtons()
        
        fetchVideos()
    }
    
    func fetchVideos() {
        
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        let session = URLSession.shared // or let session = URLSession(configuration: URLSessionConfiguration.default)
        if let usableUrl = url {
            let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
                if let data = data {
                    //JSONSerialization
                    do {
                        let json = try JSONSerialization.jsonObject(with: data)
                        self.videos = [Video]()
                        for dictionary in json as! [[String: Any]] {
                            let video = Video()
                            video.title = dictionary["title"] as? String
                            video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                            let channelItems = dictionary["channel"] as! [String:Any]
                            let channel = Channel()
                            channel.name = channelItems["name"] as? String
                            channel.profileImageName = channelItems["profile_image_name"] as? String
                            video.channel = channel
                            self.videos?.append(video)
                        }
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                            
                        }
                    } catch {
                        print(error)
                    }
                }
            })
            task.resume()
        }
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    func setupNavBarButtons() {
        let searchBarNavButton = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton,searchBarNavButton]
    }
    func handleSearch() {
        print("Handle search here")
    }
    let settingsLauncher = SettingsLauncher()
    
    func handleMore() {
        settingsLauncher.showSettings()
    }
    func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width-16-16) * 9/16
        return CGSize(width:view.frame.width, height:height+16+88)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

