//
//  String+Extension.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 19.02.2024.
//

import Foundation
extension String {
  
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
//    func errorHandling() {
//       
//        if self.isEmpty {
//          TextFieldView().error = "INVALID_FORMAT".localized()
//            
//        }else{
//            TextFieldView().error = nil
//        }
//    }
}
