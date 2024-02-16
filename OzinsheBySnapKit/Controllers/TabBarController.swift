//
//  TabBarController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 10.02.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let homeVC = HomeViewController()
        let favoriteVC = FavoriteViewController()
        let profileVC = ProfileViewController()
        let searchVC = SearchViewController()
        
        homeVC.tabBarItem.image = UIImage(named: "Home")
        homeVC.tabBarItem.selectedImage = UIImage(named: "HomeSelected")
        
        favoriteVC.tabBarItem.image = UIImage(named: "favorite")
        favoriteVC.tabBarItem.selectedImage = UIImage(named: "FavoriteSelected")
        
        profileVC.tabBarItem.image = UIImage(named: "Profile")
        profileVC.tabBarItem.selectedImage = UIImage(named: "ProfileSelected")
        
        searchVC.tabBarItem.image = UIImage(named: "Search")
        searchVC.tabBarItem.selectedImage = UIImage(named: "SearchSelected")
        //дополнить
        let VCs = [UINavigationController(rootViewController: homeVC), favoriteVC, profileVC, searchVC]
        setViewControllers(VCs, animated: true)
        
        }
        
    }



