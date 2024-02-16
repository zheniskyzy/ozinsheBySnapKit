//
//  ReusableFuncs.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 16.02.2024.
//

import Foundation
import UIKit

class ReusableFuncs {
    func startApp(_ viewController: UIViewController){
        let tabBarVC = TabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        viewController.present(tabBarVC, animated: true)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    func errorHandling(email: String) {
       
        if email.isEmpty {
          TextFieldView().error = "INVALID_FORMAT".localized()
            
        }else{
            TextFieldView().error = nil
        }
        
    }
}
