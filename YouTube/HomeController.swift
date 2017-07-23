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
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let titleView = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleView.textColor = UIColor.white
        titleView.text = "  Home"
        titleView.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleView
        navigationController?.navigationBar.isTranslucent = false
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
        
        fetchVideos()
    }
    
    func fetchVideos() {
        
        //trailing closure implementation
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView?.reloadData()

        }
            }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            collectionView?.isPagingEnabled = true
            flowLayout.minimumLineSpacing = 1

        }
/*       compare with app delegate
         let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal     */
        collectionView?.backgroundColor = UIColor.white
        //collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
    }
    func setupNavBarButtons() {
        let searchBarNavButton = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton,searchBarNavButton]
    }
    func handleSearch() {
        print("Handle search here")
    }
    func scrollToMenuIndex(menuIndex: Int) {
       let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .init(rawValue: 0), animated: true)
    }
   lazy var settingsLauncher: SettingsLauncher = {
        let settingsLauncher = SettingsLauncher()
        settingsLauncher.homecontroller = self
        return settingsLauncher
    }()
    
    func handleMore() {
        settingsLauncher.showSettings()
    }
    func showControllerForSettings(setting: Setting) {
        let dummyViewController = UIViewController()
        dummyViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        dummyViewController.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(dummyViewController, animated: true)
    }
    func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 232, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
       // this will pin to the top most layout to the menu bar
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / 4
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.move().x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let colors: [UIColor] = [.blue, .green, UIColor.gray, UIColor.yellow]
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return videos?.count ?? 0
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cellId", for: indexPath) as! VideoCell
//        cell.video = videos?[indexPath.item]
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.width-16-16) * 9/16
//        return CGSize(width:view.frame.width, height:height+16+88)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}

