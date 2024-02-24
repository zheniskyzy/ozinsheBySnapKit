//
//  UIFont+Extension.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 16.02.2024.
//

import UIKit

extension UIFont {
    enum FontWeight: String {
        case regular = "Regular"
        case bold = "Bold"
        case semibold = "Semibold"
    }
    
    func addFont(ofSize: Double, weight: FontWeight) -> UIFont
    {
        if let font = UIFont(name: "SFProDisplay-\(weight)", size: ofSize){
            return font
        }else{
            fatalError()
        }
    }
    
}
