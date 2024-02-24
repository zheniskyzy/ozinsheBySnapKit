//
//  UIViewController+EXtension.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 19.02.2024.
//

import Foundation
import UIKit

extension UIViewController{
    
    func startApp(_ viewController: UIViewController){
        let tabBarVC = TabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        viewController.present(tabBarVC, animated: true)
    }
}
