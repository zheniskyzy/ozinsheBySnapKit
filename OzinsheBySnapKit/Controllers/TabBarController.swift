//
//  TabBarController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 10.02.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    let homeVC = HomeViewController()
    let searchVC = SearchViewController()
    let favoriteVC = FavoriteTableViewController()
    let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "white-1C2431")
        tabBar.backgroundColor = UIColor(named: "white-1C2431")
      
        
        homeVC.tabBarItem.image = UIImage(named: "Home")
        searchVC.tabBarItem.image = UIImage(named: "Search")
        favoriteVC.tabBarItem.image = UIImage(named: "favorite")
        profileVC.tabBarItem.image = UIImage(named: "Profile")
        
        let VCs = [CustomNavigationController(rootViewController: homeVC),
                   CustomNavigationController(rootViewController: searchVC),
                   CustomNavigationController(rootViewController: favoriteVC),
                   CustomNavigationController(rootViewController: profileVC)]
        
        setViewControllers(VCs, animated: true)
        }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        tabBar.frame.size.height = 95
        homeVC.tabBarItem.selectedImage = UIImage(named: "HomeSelected")!.withRenderingMode(.alwaysOriginal)
        searchVC.tabBarItem.selectedImage = UIImage(named: "SearchSelected")!.withRenderingMode(.alwaysOriginal)
        favoriteVC.tabBarItem.selectedImage = UIImage(named: "FavoriteSelected")!.withRenderingMode(.alwaysOriginal)
        profileVC.tabBarItem.selectedImage = UIImage(named: "ProfileSelected")!.withRenderingMode(.alwaysOriginal)
    }
}

