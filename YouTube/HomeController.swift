//
//  ViewController.swift
//  YouTube
//
//  Created by Vijayanadk on 7/14/17.
//  Copyright © 2017 Vijayanadk. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    let titles = ["Home","Trending","Subscriptions","Account"]

    
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
            flowLayout.minimumLineSpacing = 0

        }
/*       compare with app delegate
         let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal     */
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
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
        setTitleForIndex(index: menuIndex)
    }
    
    private func setTitleForIndex(index:Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[Int(index)])"
        }
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
       setTitleForIndex(index: Int(index))
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let identifier: String
        if indexPath.item == 1 {
            identifier = trendingCellId
        }
        else if indexPath.item == 2 {
            identifier = subscriptionCellId
        }
        else {
            identifier = cellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
}

