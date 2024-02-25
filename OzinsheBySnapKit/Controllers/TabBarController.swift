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

        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favoriteVC = FavoriteViewController()
        let profileVC = ProfileViewController()
        
        
        homeVC.tabBarItem.image = UIImage(named: "Home")
        homeVC.tabBarItem.selectedImage = UIImage(named: "HomeSelected")
        
        searchVC.tabBarItem.image = UIImage(named: "Search")
        searchVC.tabBarItem.selectedImage = UIImage(named: "SearchSelected")
        
        favoriteVC.tabBarItem.image = UIImage(named: "favorite")
        favoriteVC.tabBarItem.selectedImage = UIImage(named: "FavoriteSelected")
        
        profileVC.tabBarItem.image = UIImage(named: "Profile")
        profileVC.tabBarItem.selectedImage = UIImage(named: "ProfileSelected")
        
        let VCs = [CustomNavigationController(rootViewController: homeVC),
                   CustomNavigationController(rootViewController: searchVC),
                   CustomNavigationController(rootViewController: favoriteVC),
                   CustomNavigationController(rootViewController: profileVC)]
        
        setViewControllers(VCs, animated: true)
        }
        
    }



